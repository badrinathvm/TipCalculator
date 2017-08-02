//
//  TipAmountViewCell.swift
//  TipCalculator
//
//  Created by Badrinath on 8/1/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class TipAmountViewCell: UITableViewCell {

    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet var tipAmountTopConstraint: NSLayoutConstraint!
    
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
