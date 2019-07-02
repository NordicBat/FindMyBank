//
//  TableViewController.swift
//  FindMyBank
//
//  Created by GabrielVM on 30/06/19.
//  Copyright © 2019 GabrielVM. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class TableViewController: UITableViewController {
    
    var officesArray: [Office] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        updateArray()
        //updateArrayAPI()
        tableView.reloadData()
        
       
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    // MARK: - Fill array function
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
    
    // Func to try to download the data and create a PLIST with the response, not finished, need fix!!
    private func updateArrayAPI(){
        
        let urlAPI = "https://service.bmf.gv.at/Finanzamtsliste.json"
        
        let documentDirectoryURL =  FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = documentDirectoryURL.appendingPathComponent("Offices.plist")
        
        DispatchQueue.main.async {
            
            let request = URLRequest(url: URL(string: urlAPI)!)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                guard let data = data, error == nil else { return }
                
                let json = try? JSON(data: data)

                
                for office in json?.arrayValue ?? [] {
                    let dictionary = office
                    print(dictionary)
                    do {
                        try PropertyListEncoder().encode(dictionary).write(to: fileURL)
                    } catch {
                        print(error)
                    }
                    
                }
                do {
                    let data = try Data(contentsOf: fileURL)
                    let offices = try PropertyListDecoder().decode([String: String].self, from: data)
                    for _ in offices {
                        let newOffice = Office.init(id: offices["DisKz"] ?? "", name: offices["DisNameLang"] ?? "", zip: offices["DisPlz"] ?? "", city: offices["DisOrt"] ?? "", phone: offices["DisTel"] ?? "", street: offices["DisStrasse"] ?? "", openingHour: offices["DisOeffnung"] ?? "", imgURL: offices["DisFotoUrl"] ?? "", lat: offices["DisLatitude"] ?? "", long: offices["DisLongitude"] ?? "")
                        self.officesArray.append(newOffice)
                    }
                    
                } catch {
                    self.updateArray()
                }
                
                
            })
            task.resume()
            
        }
       
    }
    
}
