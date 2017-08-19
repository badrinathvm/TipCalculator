//
//  CountryListViewCell.swift
//  TipCalculator
//
//  Created by Badrinath on 8/19/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class CountryListViewCell: UITableViewCell {

    @IBOutlet weak var countryListLabel: UILabel!
    
    var ctyName:String!{
        didSet{
            self.countryListLabel.text = ctyName!
        }
    }
}
