//
//  DetailViewController.swift
//  FindMyBank
//
//  Created by GabrielVM on 01/07/19.
//  Copyright © 2019 GabrielVM. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var name: String = ""
    var imgUrl: String = ""
    var address: String = ""
    var openHours: String = ""
    var phone: String = ""
    var lat: String = ""
    var long: String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var openingHoursLabel: UITextView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        addressLabel.text = address
        openingHoursLabel.text = openHours
        phoneLabel.text = phone
        
    }
    
    @IBAction func displayMap(_ sender: UIButton) {
        performSegue(withIdentifier: "showMap", sender: self)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! MapViewController
        
        destinationVC.lat = Double(self.lat) ?? 0
        destinationVC.long = Double(self.long) ?? 0
        
    }
 

}
