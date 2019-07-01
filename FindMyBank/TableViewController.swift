//
//  TableViewController.swift
//  FindMyBank
//
//  Created by GabrielVM on 30/06/19.
//  Copyright © 2019 GabrielVM. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController: UITableViewController {
    
    var officesArray: [Office] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateArray()
        tableView.reloadData()
        self.title = "Financial Offices"
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return officesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let name = officesArray[indexPath.row].name
        
        cell.textLabel?.text = name
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
    }
    
    private func updateArray(){
        
        do {
            
            let path = Bundle.main.url(forResource: "Offices", withExtension: "json")
            let jsonData = try String(contentsOf: path!, encoding: .utf8)
            let jsonFinal = JSON(parseJSON: jsonData)
            
            for office in jsonFinal.arrayValue {
                let newOffice = Office.init(id: office["DisKz"].stringValue, name: office["DisNameLang"].stringValue, zip: office["DisPlz"].stringValue, city: office["DisOrt"].stringValue, phone: office["DisTel"].stringValue, street: office["DisStrasse"].stringValue, openingHour: office["DisOeffnung"].stringValue, imgURL: office["DisFotoUrl"].stringValue, lat: office["DisLatitude"].stringValue, long: office["DisLongitude"].stringValue)
                
                self.officesArray.append(newOffice)
            }
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
}
