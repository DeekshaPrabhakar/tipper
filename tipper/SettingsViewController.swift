//
//  SettingsViewController.swift
//  tipper
//
//  Created by Deeksha Prabhakar on 9/23/16.
//  Copyright © 2016 Deeksha Prabhakar. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var purpleThemeControl: UISwitch!

    @IBOutlet weak var pinkThemeControl: UISwitch!
    
    @IBOutlet weak var cyanThemeControl: UISwitch!
    
    @IBOutlet weak var tipSettingsControl: UISegmentedControl!
    
    
    @IBOutlet weak var defaultTipLabel: UILabel!
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var themeLblRightLine: UIView!
    
    @IBOutlet weak var themeLblLeftLine: UIView!
    //Properties
    private var brain = TipperBrain()

    @IBAction func updateDefaultTip(_ sender: AnyObject) {
        brain.updateDefaultTip(tipPercent: tipSettingsControl.selectedSegmentIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUIToCurrentTheme()
        brain.getDefaultTip()
        
        if(brain.defaultTipIndex < tipSettingsControl.numberOfSegments) {
            tipSettingsControl.selectedSegmentIndex = brain.defaultTipIndex
        }
        //print("view will appear")
    }
    
    func updateUIToCurrentTheme() {
        let themeCurrentColor = brain.getCurrentTheme()
        let themeColor = brain.getThemeColor(themeColor: themeCurrentColor)
        updateUI(themeDarkColor: themeColor.1, themeLightColor: themeColor.0)
        if(themeCurrentColor == "Purple"){
            pinkThemeControl.setOn(false, animated: true)
            cyanThemeControl.setOn(false, animated: true)
            purpleThemeControl.setOn(true, animated: true)

        }
        else if(themeCurrentColor == "Pink"){
            purpleThemeControl.setOn(false, animated: true)
            cyanThemeControl.setOn(false, animated: true)
            pinkThemeControl.setOn(true, animated: true)
        }
        else if(themeCurrentColor == "Cyan"){
            purpleThemeControl.setOn(false, animated: true)
            pinkThemeControl.setOn(false, animated: true)
            cyanThemeControl.setOn(true, animated: true)
        }
    }
    
    @IBAction func onThemeSelectPurple(_ sender: AnyObject) {
        pinkThemeControl.setOn(false, animated: true)
        cyanThemeControl.setOn(false, animated: true)
        brain.updateCurrentTheme(theme: "Purple")
        updateUITheme(selectedTheme: "Purple")
    }
 
    @IBAction func onThemeSelectPink(_ sender: AnyObject) {
        purpleThemeControl.setOn(false, animated: true)
        cyanThemeControl.setOn(false, animated: true)
         brain.updateCurrentTheme(theme: "Pink")
        updateUITheme(selectedTheme: "Pink")
    }
   
    @IBAction func onThemeSelectCyan(_ sender: AnyObject) {
        purpleThemeControl.setOn(false, animated: true)
        pinkThemeControl.setOn(false, animated: true)
         brain.updateCurrentTheme(theme: "Cyan")
        updateUITheme(selectedTheme: "Cyan")
    }
    
    func updateUITheme(selectedTheme: String) {
        let themeColor = brain.getThemeColor(themeColor: selectedTheme)
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
             self.updateUI(themeDarkColor: themeColor.1, themeLightColor: themeColor.0)
            }, completion: nil)
    }
    
    private func updateUI(themeDarkColor: UIColor, themeLightColor: UIColor){
        self.view.backgroundColor = themeLightColor
        tipSettingsControl.tintColor = themeDarkColor
        defaultTipLabel.textColor = themeDarkColor
        themeLabel.textColor = themeDarkColor
        themeLblLeftLine.backgroundColor = themeDarkColor
        themeLblRightLine.backgroundColor = themeDarkColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
