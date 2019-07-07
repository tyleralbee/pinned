//
//  ViewController.swift
//  pinned
//
//  Created by Tyler Albee on 7/7/19.
//  Copyright © 2019 Tyler Albee. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController , CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()

    @IBOutlet weak var homeMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        
        //self.map.setRegion(viewRegion, animated: true)
        
        self.homeMap.setRegion(viewRegion, animated: true)
    }


}

