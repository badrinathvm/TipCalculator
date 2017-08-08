//
//  TipAmountViewCell.swift
//  TipCalculator
//
//  Created by Badrinath on 8/1/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class TipAmountViewCell: UITableViewCell {

    @IBOutlet weak var tipAmountContentView: UIView!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet var tipAmountTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var plusLabel: UILabel!
    
    var tipAmount:Double!{
        didSet{
            tipAmountLabel.text = "\(tipAmount!)"
        }
    }
    
    var topValue: CGFloat!{
        didSet{
            tipAmountTopConstraint.constant = topValue!
        }
    }
    
}
