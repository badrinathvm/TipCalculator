//
//  TipPercentageViewCell.swift
//  TipCalculator
//
//  Created by Badrinath on 8/1/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class TipPercentageViewCell: UITableViewCell {

   
    @IBOutlet weak var percentageSegmentControl: UISegmentedControl!
    
    
    @IBAction func percentageChnaged(_ sender: Any) {
        
        switch percentageSegmentControl.selectedSegmentIndex{
        
        case 0: print ("10%")
                TipTableViewController.percentageHolder = 10.0
                
        case 1: print ("15%")
                TipTableViewController.percentageHolder = 15.0
            
        case 2: print ("20%")
                TipTableViewController.percentageHolder = 20.0
            
        default : break
            
        }
    
    }

}
