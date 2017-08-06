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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingsViewController.back))
        
        self.navigationItem.leftBarButtonItem = newBackButton

    }
    
    func back(){
        self.navigationController?.popViewController(animated: false)
    }
    
    func savePercentage(percentageIndex:String){
        let defaults = UserDefaults.standard
        defaults.set(percentageIndex, forKey: "percentageIndex")
        defaults.synchronize()
    }

}


