//
//  SecondViewController.swift
//  project1Legal
//
//  Created by Nathan Beard on 2/28/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController {

    
    // This will be the map view of Boulder county that has all the nonprofit and pro bono legal services
    // Put privacy permission in plist
    // Connect mapView from storyboard @IBOutlet weak var mapView: MKMapView!
    //
    
    
    
    override func viewDidLoad() {
        
        /*
 
        mapView.mapType=MKMapType.hybrid //hybrid with map and satellite
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest // specify the desired accuracy
        locationManager.distanceFilter=kCLDistanceFilterNone //specify distance device must move laterally (meters) to generate update. We specify to be noticed of all movements
        mapView.showsUserLocation=true
         
        */
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



// Code from location app from first semester:
/*
 
 //CLLocationManagerDelegate methods
 
 //called when a new location value is available
 //check steve morse .org for long/lat of my location in simulator
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
 let span = MKCoordinateSpanMake(0.05, 0.05) // defines the area spanned by a map region
 let region = MKCoordinateRegionMake(manager.location!.coordinate, span) // region of the map to be displayed
 mapView.setRegion(region, animated: true)
 
 // annotations add markers to the map to represent our location
 annotation.coordinate=manager.location!.coordinate
 annotation.title="You are here"
 annotation.subtitle="Latitude: \(manager.location!.coordinate.latitude), Longitude: \(manager.location!.coordinate.longitude)"
 mapView.addAnnotation(annotation)
 }
 
 
 // called when the authorization status for the application changed.
 func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
 if status == CLAuthorizationStatus.authorizedWhenInUse {
 locationManager.startUpdatingLocation() // starts the location manager
 }
 }
 
 
 //called when a location cannot be determined
 func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
 var errorType=String()
 if let CLError=CLError.Code(rawValue: error._code) {
 if CLError == .denied {
 errorType="access denied"
 let alert=UIAlertController(title: "Error", message: errorType, preferredStyle: UIAlertControllerStyle.alert)
 let okAction:UIAlertAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
 alert.addAction(okAction)
 present(alert, animated: true, completion: nil)
 }
 }
 }
 
 
 

*/
