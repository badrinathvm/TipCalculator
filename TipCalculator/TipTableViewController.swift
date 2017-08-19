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
    static var backFlag:Bool = false
    
    //Fields for color Changes
    
    
    
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
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.tableFooterView = UIView()
        print(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        if let percentageIndex = defaults.object(forKey: "percentageIndex") as? String {
             tipPercentage?.selectIndex = Int(percentageIndex)
            print(percentageIndex)
        }
        
        self.checkThemeState()
        
        
        if let selectedCode = defaults.object(forKey: "code") as? String {
            //tipPercentage?.selectIndex = Int(percentageIndex)
            print("Selected Code is \(selectedCode)")
        }
        
        
        
    }

    
   /* override func viewDidAppear(_ animated: Bool) {
        if(TipTableViewController.backFlag){
            self.tipChange()
        }
     
    }*/
    
    func checkThemeState(){
        let defaults = UserDefaults.standard
        if let stateChange = defaults.object(forKey: "state") as? String {
            if (stateChange == "dark"){
                self.darkTheme()
            }else if (stateChange == "light"){
                self.lightTheme()
            }
        }
    }
    
    func darkTheme(){
        input?.inputTextContentView.backgroundColor = UIColor.black
        input?.inputTextField.textColor = UIColor.white
        
        tipPercentage?.tipPercentageContentView.backgroundColor = UIColor.black
        tipPercentage?.tintColor = UIColor.white
        tipPercentage?.percentageSegmentControl.tintColor = Styles.titleColor
        tipPercentage?.percentageSegmentControl.backgroundColor = UIColor.black
        
        tip?.plusLabel.textColor = UIColor.white
        tip?.tipAmountLabel.textColor = UIColor.white
        tip?.tipAmountContentView.backgroundColor = UIColor.black
        
        finalAmount?.equalsLabel.textColor = UIColor.white
        finalAmount?.finalAmountLabel.textColor = UIColor.white
        finalAmount?.finalAmountContentView.backgroundColor = UIColor.black
        
        tableView.tableFooterView?.backgroundColor = UIColor.black
    }
    
    func lightTheme(){
        
        input?.inputTextContentView.backgroundColor = Styles.inputViewCell
        input?.inputTextField.textColor = UIColor.black
        
        tipPercentage?.tipPercentageContentView.backgroundColor = Styles.inputViewCell
        tipPercentage?.tintColor = UIColor.darkGray
        tipPercentage?.percentageSegmentControl.tintColor = UIColor.darkGray
        tipPercentage?.percentageSegmentControl.backgroundColor = Styles.inputViewCell
        
        tip?.plusLabel.textColor = UIColor.black
        tip?.tipAmountLabel.textColor = UIColor.black
        tip?.tipAmountContentView.backgroundColor = Styles.tipFinalAmountCell
        
        finalAmount?.equalsLabel.textColor = UIColor.black
        finalAmount?.finalAmountLabel.textColor = UIColor.black
        finalAmount?.finalAmountContentView.backgroundColor = Styles.tipFinalAmountCell
    }
    
    
    
    func textFieldDidChange(textField: UITextField){
        
        if var amount = textField.text?.formatCurrency() {
            print("\((amount))")
            amount = amount.replacingOccurrences(of: ",", with: "")
            input?.updateTextValue = amount
            
            if(amount == ""){
                self.tip?.isHidden = true
                self.tipPercentage?.isHidden = true
                self.finalAmount?.isHidden = true
            }
            
        
            if  (amount.characters.count > 0 ){
                
                //set back to original layout
                self.input?.topValue = -5.0
                
                //set back row height
                self.tip?.isHidden = false
                self.tipPercentage?.isHidden = false
                self.finalAmount?.isHidden = false
                
                if (amount.contains(",")){
                    self.simplifiedAmount = Double(amount.substring(from: 1))!
                }else{
                    self.simplifiedAmount = Double(amount.substring(from: 1))!
                }
                
                //Calculatin tip amount
                let simplifiedTipAmount = (self.simplifiedAmount! * Double(TipTableViewController.percentageHolder/100.0)).roundTo(places: 2)
                tip?.tipAmount = simplifiedTipAmount
                
                //Calculating final amount
               finalAmount?.finalResult = (self.simplifiedAmount! + simplifiedTipAmount).roundTo(places:2)
                
                self.saveFormattedAmount(finalAmount: (self.simplifiedAmount)!)
            }
        }
        
    }
    
     func tipChange(){
        
        var value:Double?
        
        if( tipPercentage != nil){
            
            switch (tipPercentage?.percentageSegmentControl.selectedSegmentIndex)!{
                
            case 0: value = 10.0
                
            case 1: value = 15.0
                
            case 2: value = 20.0
                
            default : break
                
            }
            
            //set back row height
            self.tip?.isHidden = false
            self.tipPercentage?.isHidden = false
            self.finalAmount?.isHidden = false
            
            let defaults = UserDefaults.standard
            
            if let amount = defaults.object(forKey: "textFieldAmount") as? Double {
                
                //print(amount)
                
                let simplifiedTipAmount = (amount * Double(value!/100.0)).roundTo(places: 2)
                
                self.tip?.tipAmount = simplifiedTipAmount
                
                //print(self.tip?.tipAmount)
                
                //Calculating final amount
                self.finalAmount?.finalResult = (amount + simplifiedTipAmount).roundTo(places:2)
                
            }
            
        }
    }
    
    
    func saveFormattedAmount(finalAmount:Double){
        let defaults = UserDefaults.standard
        defaults.set(finalAmount, forKey: "textFieldAmount")
        defaults.synchronize()
    }
    
//    func retainState(finalAmount: Double, tipAmount: Double, enteredAmount:Double){
//        let defaults = UserDefaults.standard
//        defaults.set(finalAmount, forKey: "finalAmount")
//        defaults.set(tipAmount, forKey: "tipAmount")
//        defaults.set(enteredAmount, forKey: "enteredAmount")
//        defaults.synchronize()
//
//    }
    
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
            
            cell.topValue = 50.0
            
            cell.inputTextField.becomeFirstResponder()
            
            //required to access input cell
            self.input = cell
            self.checkThemeState()
            //self.retainCells(input:self.input!)
            
            return cell
            
        } else if (indexPath.row == 1){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.tipPercentage, for: indexPath) as! TipPercentageViewCell
            
            self.tipPercentage = cell
        
            cell.isHidden = true
            
            cell.percentageSegmentControl.addTarget(self, action:#selector(tipChange), for: .valueChanged)
            
            self.checkThemeState()
    
            return cell
            
        } else if (indexPath.row == 2){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.tipAmount, for: indexPath) as! TipAmountViewCell
            
            cell.separatorInset = UIEdgeInsetsMake(0.0 , cell.bounds.size.width , 0.0, -cell.bounds.size.width)
            
            self.tip = cell
            
            cell.isHidden = true
            
            self.checkThemeState()
        
            return cell
            
        }else if (indexPath.row == 3){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.finalAmount, for: indexPath) as! FinalAmountViewCell
            
            self.finalAmount = cell
            
            cell.isHidden = true
            
            self.checkThemeState()
            
            return cell
        }
    
        return UITableViewCell()

    }
    
}



