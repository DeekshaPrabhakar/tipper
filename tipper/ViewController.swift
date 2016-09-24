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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        //read persisted tip index
        brain.getDefaultTip()
        
        
        if(brain.defaultTipIndex < tipControl.numberOfSegments) {
            
            //use index persisted to reflect the segmented control's selected index
            tipControl.selectedSegmentIndex = brain.defaultTipIndex
            
            //reflect the change from settings in tip and total
            if(billValue > 0){
                updateLabels()
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

