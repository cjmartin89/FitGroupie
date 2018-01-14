//
//  ViewController.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/5/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Firebase
// Constants

var workoutArray = WorkoutLocationList().workout
let pizzaPin = UIImage(named: "pizza pin")
let crossHairs = UIImage(named: "crosshairs")


//MARK: Global Declarations

let homeCoordinate = CLLocationCoordinate2DMake(26.027351, -80.231457)// Home street coordinates

class MapViewViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager?
    
    // IB Outlet

    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
    }
    
    // Resign Keyboard On Background Touch
    
 
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.distanceFilter = kCLDistanceFilterNone
//        mapView.showsUserLocation = true
        
        
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager!.startUpdatingLocation()
        } else {
            locationManager!.requestWhenInUseAuthorization()
        }
        
        

        retrieveWorkouts()
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        
        switch status {
        case .notDetermined:
            print("NotDetermined")
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            print("AuthorizedAlways")
        case .authorizedWhenInUse:
            print("AuthorizedWhenInUse")
            locationManager!.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.first!
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 3000, 3000)
        mapView.setRegion(coordinateRegion, animated: true)
        locationManager?.stopUpdatingLocation()
        locationManager = nil
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to initialize GPS: ", error.description)
    }

    //MARK: - Annotations
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? WorkoutLocation{
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier){
                return view
            }else{
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
                view.image = pizzaPin
                view.isEnabled = true
                view.canShowCallout = true
                view.leftCalloutAccessoryView = UIImageView(image: pizzaPin)
                let btn = UIButton(type: .detailDisclosure)
                view.rightCalloutAccessoryView = btn
                return view
            }
        }
        return nil
    }

    //MARK: - Map setup
    
    func retrieveWorkouts() {
        
        let workoutDB = Database.database().reference().child("Workouts")
        
        workoutDB.observe(.childAdded, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, Any>
            
            let workoutName = snapshotValue["Workout Name"]!
            let workoutAddress = snapshotValue["Workout Address"]!
            let workoutTime = snapshotValue["Workout Time"]!
            let workoutType = snapshotValue["Workout Type"]
            let workoutDuration = snapshotValue["Workout Duration"]
            let latitude = snapshotValue["Latitude"]
            let longitude = snapshotValue["Longitude"]
            
            print(workoutName, workoutAddress, workoutTime, workoutType!, workoutDuration!)
            
            let workoutLocation = WorkoutLocation(name: workoutName as! String, lat: latitude as! CLLocationDegrees, long: longitude as! CLLocationDegrees)
            workoutArray.append(workoutLocation)
            self.mapView.addAnnotations(workoutArray)
        })
    }
    
    func resetRegion(){
        let region = MKCoordinateRegionMakeWithDistance(homeCoordinate, 5000, 5000)
        mapView.setRegion(region, animated: true)
    }

    
    //MARK: Life Cycle

}
