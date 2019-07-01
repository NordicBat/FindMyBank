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
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var textArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: self.imgUrl)
        
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            self.imgView.image = UIImage(data: imageData)
        } else {
            self.imgView.image = UIImage(named: "notfound.png")
        }
        
        
        textArea.text = """
        \(self.name)\n
        Address:
        \(self.address)\n
        Opening Hours:
        \(self.openHours)\n
        Phone:
        \(self.phone)
        """
        
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
