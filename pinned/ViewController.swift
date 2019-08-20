//
//  ViewController.swift
//  pinned
//
//  Created by Tyler Albee on 7/7/19.
//  Copyright © 2019 Tyler Albee. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
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
        
        db.collection("pins").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let myLat = document.data()["latitude"]
                    let myLong = document.data()["longitude"]
                    
                    let pinner2 = MKPointAnnotation()
                    pinner2.coordinate.latitude = myLat as! CLLocationDegrees
                    pinner2.coordinate.longitude = myLong as! CLLocationDegrees
                    
                    self.homeMap.addAnnotation(pinner2)
                    
                    print("pinner2 added!")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        
        self.homeMap.setRegion(viewRegion, animated: true)
        
    }
}


