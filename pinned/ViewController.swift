//
//  ViewController.swift
//  pinned
//
//  Created by Tyler Albee on 7/7/19.
//  Copyright © 2019 Tyler Albee. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation

var pinSet = [MKPointAnnotation]()


class HomeMapController : UIViewController , CLLocationManagerDelegate , MKMapViewDelegate {
    
    var locationManager = CLLocationManager()

    @IBOutlet weak var homeMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        for loc in locationChosen{
            let pinner = MKPointAnnotation()
            pinner.coordinate = loc
            homeMap.addAnnotation(pinner)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        
        self.homeMap.setRegion(viewRegion, animated: true)
        
    }
}


