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

let pizzaPin = UIImage(named: "pizza pin")
let crossHairs = UIImage(named: "crosshairs")

// Variables

var workoutName : String = ""
var workoutType : String = ""
var workoutAddress : String = ""
var workoutDate : Date = Date.init()
var workoutDuration : Int = 0
var activityLevel : String = ""
var workoutArray = kWorkoutList_KEY

var modelController: ModelController!


//MARK: Global Declarations

let homeCoordinate = CLLocationCoordinate2DMake(26.027351, -80.231457)// Home street coordinates

class MapViewViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // Variables
    
    var locationManager : CLLocationManager?
//    var workoutArray = kWorkoutList_KEY
    var modelController: ModelController!
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        workoutArray = kWorkoutList_KEY
        addAnnotations()
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? WorkoutLocation {
            workoutName = annotation.title ?? "Name"
            workoutAddress = annotation.workoutAddress
            workoutType = annotation.workoutType
            workoutDuration = annotation.workoutDuration
            activityLevel = annotation.activityLevel
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "mapDetailView", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapDetailView" {
            let workoutDetailViewController = segue.destination as! WorkoutDetailViewController
            workoutDetailViewController.workoutName = workoutName
            workoutDetailViewController.workoutAddress = workoutAddress
            workoutDetailViewController.workoutType = workoutType
            workoutDetailViewController.workoutDuration = workoutDuration
            workoutDetailViewController.activityLevel = activityLevel
        }
        else {
            return
        }
    }
    
    func addAnnotations() {
        mapView.addAnnotations(workoutArray)
    }
    
    func resetRegion(){
        let region = MKCoordinateRegionMakeWithDistance(homeCoordinate, 5000, 5000)
        mapView.setRegion(region, animated: true)
    }

    
    //MARK: Life Cycle

}
