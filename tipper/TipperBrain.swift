//
//  TipperBrain.swift
//  tipper
//
//  Created by Deeksha Prabhakar on 9/23/16.
//  Copyright © 2016 Deeksha Prabhakar. All rights reserved.
//

import UIKit

class TipperBrain: NSObject {
    
    var defaultTipIndex = 0
    private var appBackgroundEnterTime: NSDate? = nil
    
    var tipAmount = 0.0
    var totalAmount = 0.0
    
    private var tipPercentage = 0.0
    private var billAmount = 0.0
    
    //read persisted data
    func getDefaultTip() {
        let defaults = UserDefaults.standard
        defaultTipIndex = defaults.integer(forKey: "DefaultTipIndex") //returns zero if not set, so safe
    }
    
    private func getAppEnterBackgroundTime() {
        let defaults = UserDefaults.standard
        appBackgroundEnterTime = defaults.object(forKey: "BgEnterTime") as! NSDate?
    }
    
    func getLastBillAmount() -> Double {
        let defaults = UserDefaults.standard
        let lastBillAmount = defaults.double(forKey: "LastBillAmount")
        return lastBillAmount
    }
    
    
    //set data to persist
    func updateDefaultTip(tipPercent: Int) {
        let defaults = UserDefaults.standard
        defaults.set(tipPercent, forKey: "DefaultTipIndex")
        defaults.synchronize()
    }
    
    func updateAppEnterBackgroundTime() {
        let defaults = UserDefaults.standard
        defaults.set(NSDate(), forKey: "BgEnterTime")
        defaults.synchronize()
    }
    
    func updateLastBillAmount(bill: Double) {
        let defaults = UserDefaults.standard
        defaults.set(bill, forKey: "LastBillAmount")
        defaults.synchronize()
    }
    
    //set private variables
    func setTipNBill(bill: Double, tipPercent: Double) {
        tipPercentage = tipPercent
        billAmount = bill
    }
    
    //calcualte Tip and Total
    func calculateTipNTotal() {
        tipAmount = billAmount *  tipPercentage
        totalAmount = billAmount + tipAmount
    }
    
    func appBackInTenMins() {

        getAppEnterBackgroundTime()
        let currentDateTime = NSDate()
        let interval = currentDateTime.timeIntervalSince(appBackgroundEnterTime as! Date)
        let ti = NSInteger(interval)
        let minutes = (ti / 60) % 60
        
        print("currentDateTime: \(currentDateTime)")
        print("appBackgroundEnterTime: \(appBackgroundEnterTime)")
        
        if (minutes < 2){
            print("within 10 mins")
            print(getLastBillAmount())
        }
        else {
            print("More than 10 mins")
            updateLastBillAmount(bill: 0.0)
        }
    }
    
    private func addMinutes(MinsToAdd: Int, dt:NSDate) -> NSDate {
        let secondsInHours: TimeInterval = Double(MinsToAdd) * 60
        let dateWithHoursAdded: NSDate = dt.addingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }

}
