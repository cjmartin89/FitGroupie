//
//  WorkoutLocation.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/5/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class WorkoutLocation: NSObject, MKAnnotation {
    var identifier = "Workout Location"
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var workoutType : String = ""
    var workoutAddress : String = ""
    var workoutDate : Date
    var workoutDuration : Int = 0
    var activityLevel : String = ""
    
    init(name:String,lat:CLLocationDegrees,long:CLLocationDegrees, Address: String, Type: String, Date: Date, Duration: Int, Level: String){
        title = name
        coordinate = CLLocationCoordinate2DMake(lat, long)
        workoutAddress = Address
        workoutType = Type
        workoutDate = Date
        workoutDuration = Duration
        activityLevel = Level
    }
}

struct WorkoutLocationList {
    var workout = [WorkoutLocation]()
    var filteredWorkouts = [WorkoutLocation]()
}



