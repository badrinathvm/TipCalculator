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
            
        case 0: print ("10%")
        
        TipTableViewController.percentageHolder = 10.0
        TipTableViewController.settingSave = "0"
            
        case 1: print ("15%")
        
        TipTableViewController.percentageHolder = 15.0
        TipTableViewController.settingSave = "1"

        case 2: print ("20%")
        
        TipTableViewController.percentageHolder = 20.0
        TipTableViewController.settingSave = "2"

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

}


