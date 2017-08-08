//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Badarinath Venkatnarayansetty on 8/2/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    @IBAction func segmentChange(_ sender: AnyObject) {
        
        switch segmentControl.selectedSegmentIndex{
            
        case 0: self.savePercentage(percentageIndex: "0")
            
        case 1: self.savePercentage(percentageIndex: "1")

        case 2: self.savePercentage(percentageIndex: "2")

        default : break
            
        }
    }
    
    @IBOutlet weak var switchControl: UISwitch!
    
    @IBAction func darkThemeEnabled(_ sender: Any) {
        if switchControl.isOn {
            print("Switch is on")
            self.darkTheme()
            self.setThemeColor(state: "dark")
        } else {
            self.lightTheme()
            self.setThemeColor(state: "light")
        }
        
    }
    
    
    @IBOutlet var viewForTheme: UIView!
    
    @IBOutlet weak var darkThemeLabel: UILabel!
    
    @IBOutlet weak var defaultTipAmountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingsViewController.back))
        TipTableViewController.backFlag = true
        self.navigationItem.leftBarButtonItem = newBackButton

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let stateChange = defaults.object(forKey: "state") as? String {
            if (stateChange == "dark"){
                self.switchControl.isOn = true
                self.darkTheme()
            }else if (stateChange == "light"){
                self.switchControl.isOn = false
                self.lightTheme()
            }
        }

    }
    
    func back(){
        self.navigationController?.popViewController(animated: false)
    }
    
    func savePercentage(percentageIndex:String){
        let defaults = UserDefaults.standard
        defaults.set(percentageIndex, forKey: "percentageIndex")
        defaults.synchronize()
    }
    
    func setThemeColor(state:String){
        let defaults = UserDefaults.standard
        defaults.set(state, forKey: "state")
        defaults.synchronize()
    }
    
    func darkTheme(){
        self.viewForTheme.backgroundColor = Styles.viewBackgroundColor
        self.segmentControl.tintColor = Styles.titleColor
        self.darkThemeLabel.textColor = Styles.titleColor
        self.defaultTipAmountLabel.textColor = Styles.titleColor
    }
    
    func lightTheme(){
        self.viewForTheme.backgroundColor = Styles.titleColor
        self.segmentControl.tintColor = UIColor.darkGray
        self.darkThemeLabel.textColor = UIColor.black
        self.defaultTipAmountLabel.textColor = UIColor.black
    }

}


