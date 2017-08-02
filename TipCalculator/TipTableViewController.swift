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
    static var percentageHolder:Double = 10.0
    var input:InputViewCell?
    var tip:TipAmountViewCell?
    var simplifiedAmount:Double?
    var finalAmount:FinalAmountViewCell?
    var tipPercentage:TipPercentageViewCell?
    
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
        
        if var amount = textField.text?.formatCurrency() {
            print("Amount is \((amount))")
            amount = amount.replacingOccurrences(of: ",", with: "")
            input?.updateTextValue = amount
            
            //set back row height 
            self.tip?.isHidden = false
            self.tipPercentage?.isHidden = false
            self.finalAmount?.isHidden = false
            
            if  (amount.characters.count > 0 ){
                if (amount.contains(",")){
                    self.simplifiedAmount = Double(amount.substring(from: 1))!
                }else{
                    self.simplifiedAmount = Double(amount.substring(from: 1))!
                }
                
                //Calculatin tip amount
                let simplifiedTipAmount = (self.simplifiedAmount! * Double(10.0/100.0)).roundTo(places: 2)
                tip?.tipAmount = simplifiedTipAmount
                
                //Calculating final amount
               finalAmount?.finalResult = (self.simplifiedAmount! + simplifiedTipAmount).roundTo(places:2)
            }
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
            self.input = cell
        
            return cell
            
        } else if (indexPath.row == 1){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.tipPercentage, for: indexPath) as! TipPercentageViewCell
            
            self.tipPercentage = cell
            
             cell.isHidden = true
            
            return cell
            
        } else if (indexPath.row == 2){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.tipAmount, for: indexPath) as! TipAmountViewCell
            
            cell.separatorInset = UIEdgeInsetsMake(0.0 , cell.bounds.size.width , 0.0, -cell.bounds.size.width)
            
            self.tip = cell
            
            cell.isHidden = true
        
            return cell
            
        }else if (indexPath.row == 3){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.finalAmount, for: indexPath) as! FinalAmountViewCell
            
            self.finalAmount = cell
            
             cell.isHidden = true
            
            return cell
        }
    
        return UITableViewCell()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0){
        
        }
        
    }
    
   /* override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowHeight:CGFloat = 0.0
        
         if (indexPath.row == 1){
            //rowHeight = 0.0
         }else if (indexPath.row == 2){
             //rowHeight = 0.0
        }else if (indexPath.row == 3 ){
            //rowHeight = 0.0
        }else{
            //return 330.0
        }
        
        return rowHeight
    }*/

}



