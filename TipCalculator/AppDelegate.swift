//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Badrinath on 8/1/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var oldDate = NSDate()
    var tipTableViewController = TipTableViewController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //Stroing the date when app goes to background
        self.storeStateDate(oldDate: oldDate)
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        let defaults = UserDefaults.standard
        
        if let oldStateDate = defaults.object(forKey: "oldDate") as? NSDate {
            
            print("Previous Date is \(oldStateDate)")
            print("Current Date is \(NSDate())")
            
            let minDiff = (NSDate() as Date).offsetFrom(date: oldStateDate as Date)
            
            let minDifference = minDiff.components(separatedBy: "m")
            
            print("Difference in mins  \(minDifference)")
            
            if (Int(minDifference[0]) != nil && Int(minDifference[0])! >= 10 ){

                //Reload UI

                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "TipTableViewController") as! TipTableViewController

                let navigationController = UINavigationController(rootViewController: vc)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = navigationController
                
            }
        }
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func storeStateDate(oldDate: NSDate){
        let defaults = UserDefaults.standard
        defaults.set(oldDate, forKey: "oldDate")
        defaults.synchronize()
    }


}

//
//code for later use
// 
// 
// 
//  else {
// print("Retain State")
// 
// guard let finalAmount = defaults.object(forKey: "finalAmount") as? Double ,let tipAmount = defaults.object(forKey: "tipAmount") as? Double, let enteredAmount = defaults.object(forKey: "enteredAmount") as? Double else{
// 
// return
// }
// 
// Paint it to UI
// print(finalAmount)
// print(tipAmount)
// print(enteredAmount)
// 
// 
// }

