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
        let detail = "\(officesArray[indexPath.row].zip) \(officesArray[indexPath.row].city), \(officesArray[indexPath.row].street)"
        
        cell.textLabel?.text = name
        
        cell.detailTextLabel?.text = detail
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.name = officesArray[indexPath.row].name
            destinationVC.imgUrl = officesArray[indexPath.row].imgURL
            destinationVC.address = "\(officesArray[indexPath.row].zip) \(officesArray[indexPath.row].city), \(officesArray[indexPath.row].street)"
            destinationVC.openHours = officesArray[indexPath.row].openingHour
            destinationVC.phone = officesArray[indexPath.row].phone
            
            destinationVC.lat = officesArray[indexPath.row].lat
            destinationVC.long = officesArray[indexPath.row].long
        }
        
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
            self.officesArray.sort(by: {$0.zip < $1.zip})
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
}
