//
//  CountryTableViewController.swift
//  TipCalculator
//
//  Created by Badrinath on 8/18/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CountryTableViewController: UITableViewController {
    
    var countryDict:[String:String] = [:]
    var countryName:[String] = []
    var countryCode:[String:String] = [:]
    var letters = Set<String>()
    
    var countryArray = [Country]()
    var filteredDictionary:[String:[String]] = [:]
    var countryTupleArray: [(key: String, value: [String])] = []
    
    
    
    struct Storyboard{
        static let countryListView = "CountryListViewCell"
    }
    
    struct Country{
        var sectionName : String!
        var sectionObjects : String!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
      
        self.fetchData(completion: { flag in
            if(flag == 1){
                self.tableView.reloadData()
            }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func fetchData(completion: @escaping (Int) -> ()){
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let urlNew = "https://restcountries.eu/rest/v2/all"
        
        print("API URL is \(urlNew)")
        
        Alamofire.request(urlNew, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            
            //print(response)
            
            /*if let result = response.result.value {
             print("result is \(result)")
             
             } */
            
            let json = JSON(response.result.value!)
            
            
            if (!(json.null != nil)) {
                // print(json.array! )
                //print(json.arrayObject)
                
                for data in json.array! {
                    
                    //print(data["name"])
                    self.countryName.append(String(describing: data["name"]))
                    
                    for code in data["currencies"].array! {
                        //print(code["code"])
                        //self.countryCode.append(String(describing: code["symbol"]))
                        
                        self.countryCode[ String(describing: data["name"])] = String(describing: code["code"])
                    }
                }
                
                
                print(self.countryCode)
                
                
                for element in self.countryName {
                    self.letters.insert(String(element.characters.first!))
                }
                
                self.letters.remove("Å")
                
                print(self.letters.sorted { $0 < $1 })
                print(self.letters.count)
                
                
                self.countryName = self.countryName.sorted {$0 < $1}
                //self.countryCode = self.countryCode.sorted {$0 < $1}
                
                print(self.countryName.count)
                print(self.countryCode.count)
                
                
                for index in 0..<self.countryName.count{
                     self.countryDict[self.countryName[index]]  = String(self.countryName[index].characters.first!)
                }
                
                //print(self.countryDict)

                
                //Group country names according to alphabets
                for (key,value) in self.countryDict{
                    self.countryArray.append(Country(sectionName: value, sectionObjects: key))
                }
                
                let groupedCountry = self.countryArray.group { $0.sectionName}
                //print(groupedCountry)
                
                for (key, value) in groupedCountry {
                    
                    let temp:[Country] = value
                    
                    var result = [String]()
                    
                    for i in temp{
                        result.append(i.sectionObjects!)
                    }
                    
                    self.filteredDictionary[key] = result
                   
                }
                
               self.countryTupleArray = self.filteredDictionary.sorted{ $0.key < $1.key }
                
               print(self.countryTupleArray)
                
                completion(1)
            }
        }

    }
    
   

}

extension CountryTableViewController{
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return self.countryTupleArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.countryTupleArray[section].value.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewController.Storyboard.countryListView, for: indexPath) as! CountryListViewCell
            
             cell.ctyName = self.countryTupleArray[indexPath.section].value[indexPath.row]
            
            return cell

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         //return self.letters[self.letters.index(self.letters.startIndex, offsetBy: 1)]
        
        return self.countryTupleArray[section].key
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected one \(self.countryTupleArray[indexPath.section].value[indexPath.row])")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        let navigationController = UINavigationController(rootViewController: vc)
        vc.selectedCountry = self.countryTupleArray[indexPath.section].value[indexPath.row]
        vc.backFlag = true
        vc.selectedCode = self.countryCode[self.countryTupleArray[indexPath.section].value[indexPath.row]]!
        print(vc.selectedCode)
        self.present(navigationController, animated: true, completion: nil)
    }
    

    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return Array(self.letters).sorted()
    }
    
}

extension Array {

        func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
            var categories: [U: [Iterator.Element]] = [:]
            for element in self {
                let key = key(element)
                if case nil = categories[key]?.append(element) {
                    categories[key] = [element]
                }
            }
            return categories
    }
}
