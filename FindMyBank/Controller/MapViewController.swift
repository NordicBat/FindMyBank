//
//  MapViewController.swift
//  FindMyBank
//
//  Created by GabrielVM on 01/07/19.
//  Copyright © 2019 GabrielVM. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var lat: Double = 0
    var long: Double = 0
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.long)
        let center = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        
    }
    

}
