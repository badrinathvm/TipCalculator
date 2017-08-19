//
//  CountryNameViewCell.swift
//  TipCalculator
//
//  Created by Badrinath on 8/18/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class CountryNameViewCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    
    
    var ctyNameLabel:String!{
        didSet{
            self.countryNameLabel.text = ctyNameLabel!
        }
    }

}
