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
var newPin = MKPointAnnotation()

class HomeMapController : UIViewController , CLLocationManagerDelegate , MKMapViewDelegate {
    
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
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(HomeMapController.mapLongPress(_:))) // colon needs to pass through info
        longPress.minimumPressDuration = 1.5 // in seconds
        //add gesture recognition
        homeMap.addGestureRecognizer(longPress)
        
        //set searchCompleter delegate
        
        //searchCompleter.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (locationChosen.count ) > 0 {
            for coord in locationChosen {
                newPin.coordinate = coord
                pinSet.append(newPin)
                
                //notificationResults.append(newPin.title ?? "derp")
        
                for pin in pinSet {
                    homeMap.addAnnotation(pin)
                    print("new objects!")
                    
                }
                
            }
        } else {
            print("No objects")
        }
    }
    
    @objc func mapLongPress(_ recognizer: UIGestureRecognizer) {
        
        print("A long press has been detected.")
        
        let touchedAt = recognizer.location(in: self.homeMap) // adds the location on the view it was pressed
        let touchedAtCoordinate : CLLocationCoordinate2D = homeMap.convert(touchedAt, toCoordinateFrom: self.homeMap) // will get coordinates
        
        newPin.coordinate = touchedAtCoordinate
        homeMap.addAnnotation(newPin)
        


        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //homeMap.removeAnnotation(newPin)
        //let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        
        //let userPinAnnotation = MKPointAnnotation()
        
        //let userPinLocation = MKPinAnnotationView(annotation: userPinAnnotation, reuseIdentifier: nil)
        
        //self.map.setRegion(viewRegion, animated: true)
        
        
        //uses homeMap (swift 5)
        self.homeMap.setRegion(viewRegion, animated: true)
        
        newPin.coordinate = userLocation!.coordinate
        homeMap.addAnnotation(newPin)
    
        
        
    }
    

    
    


}


