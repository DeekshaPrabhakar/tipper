//
//  ViewController.swift
//  tipper
//
//  Created by Deeksha Prabhakar on 9/23/16.
//  Copyright © 2016 Deeksha Prabhakar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var inputBillView: UIView!
    @IBOutlet weak var resultOutputView: UIView!
    
    @IBOutlet weak var billPerPersonTwo: UILabel!
    @IBOutlet weak var billPerPersonThree: UILabel!
    @IBOutlet weak var billPerPersonFour: UILabel!
    @IBOutlet weak var billPerPersonFive: UILabel!
    @IBOutlet weak var billPerPersonSix: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var tipAddSymbolLbl: UILabel!
    @IBOutlet weak var tipTotalSeparatorLine: UIView!
    
    //Properties
    private var brain = TipperBrain()
    let currencySymbol = Locale.current.currencySymbol
    
    //Computed Property
    private var billValue: Double {
        get {
            return Double(billField.text!) ?? 0
        }
        set {
            billField.text = newValue == 0.0 ? "" : String(newValue)
        }

    }

    //Dismiss the keyboard when view tapped
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //Update tip and total on billField oneditingChanged event and tipControl valuechanged event
    @IBAction func updateTipNTotal(_ sender: AnyObject) {
        updateLabels()
        if(billValue == 0){
            fadeOutResultView()
        }
        else {
            fadeInResultView()
        }
    }
    
    func fadeInResultView() {
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.resultOutputView.alpha = 1

            }, completion: nil)
    }
    
    func fadeOutResultView() {
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.resultOutputView.alpha = 0
            
            }, completion: nil)
        /*UIView.animate(withDuration: 0.6, animations: {
            self.resultOutputView.alpha = 0
        })*/
    }
    
    func formatForCurrency(amt: Double) -> String {
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.currency
        fmt.locale = Locale.current
        fmt.maximumFractionDigits = 2
        return fmt.string(from: NSNumber(value: amt))!
    }
    
    private func updateLabels(){
        let tipPercentages = [0.18, 0.2, 0.25]
        
        brain.setTipNBill(bill: billValue, tipPercent: tipPercentages[tipControl.selectedSegmentIndex])
        brain.calculateTipNTotal()
        
        tipLabel.text = formatForCurrency(amt: brain.tipAmount)
        totalLabel.text = formatForCurrency(amt: brain.totalAmount)
        billPerPersonTwo.text = formatForCurrency(amt: (brain.totalAmount/2))
        billPerPersonThree.text = formatForCurrency(amt: (brain.totalAmount/3))
        billPerPersonFour.text = formatForCurrency(amt: (brain.totalAmount/4))
        billPerPersonFive.text = formatForCurrency(amt: (brain.totalAmount/5))
        billPerPersonSix.text = formatForCurrency(amt: (brain.totalAmount/6))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billField.becomeFirstResponder()//autofocus
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateViewData), name: NSNotification.Name(rawValue: "AppActive"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.saveViewData), name: NSNotification.Name(rawValue: "AppResignActive"), object: nil)
    }
    
    func updateViewData() {
        brain.appBackInTenMins()
        billValue =  brain.getLastBillAmount()
        updateLabels()
    }
    
    func saveViewData() {
        brain.updateLastBillAmount(bill: billValue)
        brain.updateAppEnterBackgroundTime()
    }
    
    func updateUITheme() {
        let themeCurrentColor = brain.getCurrentTheme()
        let themeColor = brain.getThemeColor(themeColor: themeCurrentColor)
        self.view.backgroundColor = themeColor.0
        tipControl.tintColor = themeColor.1
        billField.textColor = themeColor.1
        totalLabel.textColor = themeColor.1
        tipLabel.textColor = themeColor.1
        billAmountLabel.textColor = themeColor.1
        tipAddSymbolLbl.textColor = themeColor.1
        billPerPersonTwo.textColor = themeColor.1
        billPerPersonThree.textColor = themeColor.1
        billPerPersonFour.textColor = themeColor.1
        billPerPersonFive.textColor = themeColor.1
        billPerPersonSix.textColor = themeColor.1
        tipTotalSeparatorLine.backgroundColor = themeColor.1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        updateUITheme()
        self.inputBillView.alpha = 0
        self.resultOutputView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            // This causes first view to fade in and second view to fade out
            self.inputBillView.alpha = 1
            //self.secondView.alpha = 0
        })
        
        //read persisted tip index
        brain.getDefaultTip()
        
        
        if(brain.defaultTipIndex < tipControl.numberOfSegments) {
            
            //use index persisted to reflect the segmented control's selected index
            tipControl.selectedSegmentIndex = brain.defaultTipIndex
            
            //reflect the change from settings in tip and total
            if(billValue > 0){
                updateLabels()
                fadeInResultView()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
}

