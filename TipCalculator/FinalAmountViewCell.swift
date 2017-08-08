//
//  FinalAmountViewCell.swift
//  TipCalculator
//
//  Created by Badrinath on 8/1/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class FinalAmountViewCell: UITableViewCell {

    @IBOutlet weak var finalAmountLabel: UILabel!
    
    @IBOutlet var finalAmountTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var finalAmountContentView: UIView!
    
    @IBOutlet weak var equalsLabel: UILabel!
    
    var finalResult:Double!{
        didSet{
            finalAmountLabel.text = "$\(finalResult!)"
        }
    }
    
    var topValue: CGFloat!{
        didSet{
            finalAmountTopConstraint.constant = topValue!
        }
    }
    
    
}
