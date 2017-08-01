//
//  TipTableViewController.swift
//  TipCalculator
//
//  Created by Badrinath on 8/1/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class TipTableViewController: UITableViewController {
    
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
            
            cell.separatorInset = UIEdgeInsetsMake(0.0 , cell.bounds.size.width , 0.0, -cell.bounds.size.width)
        
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

}


