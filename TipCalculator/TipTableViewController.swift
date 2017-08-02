//
//  TipTableViewController.swift
//  TipCalculator
//
//  Created by Badrinath on 8/1/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class TipTableViewController: UITableViewController {
    
    //placeholder for percentage
    static var percentageHolder:Double?
    var input:InputViewCell?
    
    struct Storyboard{
        static let inputView = "InputViewCell"
        static let tipPercentage = "TipPercentageViewCell"
        static let tipAmount = "TipAmountViewCell"
        static let finalAmount = "FinalAmountViewCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableFooterView = UIView()
    }
    
    
    func textFieldDidChange(textField: UITextField){
        
        if let amount = textField.text?.formatCurrency() {
            print("Amount is \((amount))")
            input?.updateTextValue = amount
        }
    }

}


extension TipTableViewController{
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
        
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.inputView, for: indexPath) as! InputViewCell
            
            cell.inputTextField.tag = indexPath.row
            
            cell.separatorInset = UIEdgeInsetsMake(0.0 , cell.bounds.size.width , 0.0, -cell.bounds.size.width)
            
            cell.inputTextField.addTarget(self, action:#selector(textFieldDidChange(textField:)), for: UIControlEvents.allEditingEvents)
            
            //required to access
            input = cell
        
            return cell
            
        } else if (indexPath.row == 1){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.tipPercentage, for: indexPath) as! TipPercentageViewCell
            
            return cell
            
        } else if (indexPath.row == 2){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.tipAmount, for: indexPath) as! TipAmountViewCell
            
            cell.separatorInset = UIEdgeInsetsMake(0.0 , cell.bounds.size.width , 0.0, -cell.bounds.size.width)
        
            return cell
            
        }else if (indexPath.row == 3){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.finalAmount, for: indexPath) as! FinalAmountViewCell
            
            return cell
        }
    
        return UITableViewCell()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0){
            //print("Data upadted is ")
        }
        
    }

}



extension String {
    
    struct NumberFormatters {
        static let instance = NumberFormatter()
    }
    
    var doubleValue:Double? {
        return NumberFormatters.instance.number(from: self)?.doubleValue
    }
    
    var integerValue:Int? {
        return NumberFormatters.instance.number(from: self)?.intValue
    }
    
    func formatCurrency() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}


