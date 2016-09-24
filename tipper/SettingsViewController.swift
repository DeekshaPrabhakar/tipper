//
//  SettingsViewController.swift
//  tipper
//
//  Created by Deeksha Prabhakar on 9/23/16.
//  Copyright © 2016 Deeksha Prabhakar. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipSettingsControl: UISegmentedControl!
    //Properties
    private var brain = TipperBrain()

    @IBAction func updateDefaultTip(_ sender: AnyObject) {
        brain.updateDefaultTip(tipPercent: tipSettingsControl.selectedSegmentIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        brain.getDefaultTip()
        
        if(brain.defaultTipIndex < tipSettingsControl.numberOfSegments) {
            tipSettingsControl.selectedSegmentIndex = brain.defaultTipIndex
        }
        //print("view will appear")
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
