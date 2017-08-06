//
//  TipPercentageViewCell.swift
//  TipCalculator
//
//  Created by Badrinath on 8/1/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class TipPercentageViewCell: UITableViewCell {

   var tipChange = TipTableViewController()
    
    @IBOutlet weak var percentageSegmentControl: UISegmentedControl!
    
    @IBOutlet var percentageTopConstraint: NSLayoutConstraint!
    
    var selectIndex:Int!{
        didSet{
            percentageSegmentControl.selectedSegmentIndex = selectIndex
        }
    }
    
    var topValue: CGFloat!{
        didSet{
            percentageTopConstraint.constant = topValue!
        }
    }

}
