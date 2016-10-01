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
    
    func getCurrentTheme() -> String {
        let defaults = UserDefaults.standard
        let theme = defaults.string(forKey: "CurrentTheme")
        return theme!
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
    
    func updateCurrentTheme(theme: String) {
        let defaults = UserDefaults.standard
        defaults.set(theme, forKey: "CurrentTheme")
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
        
        if (minutes < 10){//less than 10 mins
            print("within 10 mins")
            print(getLastBillAmount())
        }
        else {
            print("More than 10 mins")
            updateLastBillAmount(bill: 0.0)
        }
    }
    
    func getThemeColor(themeColor: String) -> (UIColor, UIColor) {
        var someTuple = (lightColor : UIColor.init(red: CGFloat(243)/255, green: CGFloat(229)/255, blue: CGFloat(245)/255, alpha: 1), darkColor: UIColor.init(red: CGFloat(147)/255, green: CGFloat(62)/255, blue: CGFloat(197)/255, alpha: 1))
        switch themeColor {
        case "Purple":
            someTuple = (lightColor : UIColor.init(red: CGFloat(243)/255, green: CGFloat(229)/255, blue: CGFloat(245)/255, alpha: 1), darkColor: UIColor.init(red: CGFloat(147)/255, green: CGFloat(62)/255, blue: CGFloat(197)/255, alpha: 1))
        case "Pink":
            someTuple = (lightColor : UIColor.init(red: CGFloat(255)/255, green: CGFloat(235)/255, blue: CGFloat(238)/255, alpha: 1), darkColor: UIColor.init(red: CGFloat(255)/255, green: CGFloat(128)/255, blue: CGFloat(171)/255, alpha: 1))
        case "Cyan":
            someTuple = (lightColor : UIColor.init(red: CGFloat(225)/255, green: CGFloat(245)/255, blue: CGFloat(254)/255, alpha: 1), darkColor: UIColor.init(red: CGFloat(0)/255, green: CGFloat(188)/255, blue: CGFloat(212)/255 , alpha: 1 ))
        default:
             someTuple = (lightColor : UIColor.init(red: CGFloat(243)/255, green: CGFloat(229)/255, blue: CGFloat(245)/255, alpha: 1), darkColor: UIColor.init(red: CGFloat(147)/255, green: CGFloat(62)/255, blue: CGFloat(197)/255, alpha: 1))
        }
        return someTuple
    }
    
    private func addMinutes(MinsToAdd: Int, dt:NSDate) -> NSDate {
        let secondsInHours: TimeInterval = Double(MinsToAdd) * 60
        let dateWithHoursAdded: NSDate = dt.addingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }

}
