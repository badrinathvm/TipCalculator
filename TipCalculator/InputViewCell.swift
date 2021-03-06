//
//  TestViewCell.swift
//  TipCalculator
//
//  Created by Badrinath on 8/1/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class InputViewCell: UITableViewCell {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
   
    @IBOutlet weak var inputTextContentView: UIView!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    var updateTextValue:String!{
        didSet{
            inputTextField.text = updateTextValue
        }
    }
    
    var topValue: CGFloat!{
        didSet{
            topLayout.constant = topValue!
        }
    }
    
    
}
