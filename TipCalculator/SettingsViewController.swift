//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Badarinath Venkatnarayansetty on 8/2/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var selectedCountry:String = ""
    var backFlag:Bool = false
    var selectedCode:String = ""
    
    @IBOutlet weak var countryTableView: UITableView!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    @IBOutlet var viewForTheme: UIView!
    
    @IBOutlet weak var darkThemeLabel: UILabel!
    
    @IBOutlet weak var defaultTipAmountLabel: UILabel!
    
    @IBOutlet weak var switchControl: UISwitch!
    
    @IBAction func segmentChange(_ sender: AnyObject) {
        
        switch segmentControl.selectedSegmentIndex{
            
        case 0: self.savePercentage(percentageIndex: "0")
            
        case 1: self.savePercentage(percentageIndex: "1")

        case 2: self.savePercentage(percentageIndex: "2")

        default : break
            
        }
    }
    
    @IBAction func darkThemeEnabled(_ sender: Any) {
        if switchControl.isOn {
            print("Switch is on")
            self.darkTheme()
            self.setThemeColor(state: "dark")
        } else {
            self.lightTheme()
            self.setThemeColor(state: "light")
        }
        
    }
    
    struct Storyboard{
        static let countryNameView = "CountryNameViewCell"
        static let countryTVC = "CountryTableViewController"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingsViewController.back))
        TipTableViewController.backFlag = true
        self.navigationItem.leftBarButtonItem = newBackButton
        
        self.countryTableView.delegate = self
        self.countryTableView.dataSource = self
        
        if ( self.selectedCode.characters.count>0){
            self.setCountryCode(code: self.selectedCode)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        if let stateChange = defaults.object(forKey: "state") as? String {
            if (stateChange == "dark"){
                self.switchControl.isOn = true
                self.darkTheme()
            }else if (stateChange == "light"){
                self.switchControl.isOn = false
                self.lightTheme()
            }
        }
        


    }
    
    func back(){
        //self.navigationController?.popViewController(animated: false)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TipTableViewController") as! TipTableViewController
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func savePercentage(percentageIndex:String){
        let defaults = UserDefaults.standard
        defaults.set(percentageIndex, forKey: "percentageIndex")
        defaults.synchronize()
    }
    
    func setThemeColor(state:String){
        let defaults = UserDefaults.standard
        defaults.set(state, forKey: "state")
        defaults.synchronize()
    }
    
    func setCountryCode(code:String){
        let defaults = UserDefaults.standard
        defaults.set(code, forKey: "code")
        defaults.synchronize()
    }
    
    func darkTheme(){
        self.viewForTheme.backgroundColor = Styles.viewBackgroundColor
        self.segmentControl.tintColor = Styles.titleColor
        self.darkThemeLabel.textColor = Styles.titleColor
        self.defaultTipAmountLabel.textColor = Styles.titleColor
    }
    
    func lightTheme(){
        self.viewForTheme.backgroundColor = Styles.titleColor
        self.segmentControl.tintColor = UIColor.darkGray
        self.darkThemeLabel.textColor = UIColor.black
        self.defaultTipAmountLabel.textColor = UIColor.black
    }

}

extension SettingsViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.countryNameView, for: indexPath) as! CountryNameViewCell
            
            if self.backFlag{
                cell.ctyNameLabel = self.selectedCountry
            }
            
            return cell
        
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Region"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row is \(indexPath.row)")
        
        if (indexPath.row == 0){
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.countryTVC) as! CountryTableViewController
            //let navigationController = UINavigationController(rootViewController: vc)
            //vc.token = token!
            self.present(vc, animated: true, completion: nil)
            
        }
    }

    
}


