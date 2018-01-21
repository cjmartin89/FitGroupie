//
//  ModelController.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/20/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation


var workoutArrayList = [WorkoutLocation]()
let kWorkoutList_KEY = workoutArrayList

class ModelController {
    var workoutArray = [WorkoutLocation]()
    var filteredworkoutArray = [WorkoutLocation]()
}

func retrieveWorkouts() {
    
    let workoutDB = Database.database().reference().child("Workouts")
    
    workoutDB.observe(.childAdded, with: { (snapshot) in
        
        let snapshotValue = snapshot.value as! Dictionary<String, Any>
        
        
        let workoutName = snapshotValue["Workout Name"] as? String
        let workoutAddress = snapshotValue["Workout Address"] as? String
        let workoutTime = snapshotValue["Workout Time"]!
        let workoutType = snapshotValue["Workout Type"] as? String
        let workoutDuration = snapshotValue["Workout Duration"] as? Int
        let selectedActivityLevel = snapshotValue["Activity Level"] as? String
        let latitude = snapshotValue["Latitude"]
        let longitude = snapshotValue["Longitude"]
        
        print(workoutName ?? "Name", workoutAddress ?? "Address", workoutTime, workoutType ?? "Basketball", workoutDuration ?? 0, selectedActivityLevel ?? "Beginner")
        
        let workoutLocation = WorkoutLocation(name: workoutName ?? "Name ?" , lat: latitude as! CLLocationDegrees, long: longitude as! CLLocationDegrees, Address: workoutAddress ?? "Address ?", Type: workoutType ?? "Type", Date: Date.init(), Duration: workoutDuration ?? 0, Level: selectedActivityLevel ?? "Activity Level" )
        
        workoutArrayList.append(workoutLocation)
        print(workoutArrayList)
    })
}
