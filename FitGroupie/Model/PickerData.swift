//
//  pickerData.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/6/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseDatabase


var activityLevels = [String]()
var workoutTypesArray = [String]()

let states = [ "AK","AL","AR","AS","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA",
               "MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","RI","SC",
               "SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]

//let activityLevels = ["Beginner", "Intermediate", "Advanced"]

func retrieveActivityLevels() {
    
    let activityLevelDB = Database.database().reference().child("Activity Level")
    
    activityLevelDB.observe(.childAdded, with: { (snapshot) in
        
        let activityLevel = snapshot.value as! String
        
        print(activityLevel)

        activityLevels.append(activityLevel)
        
        print(activityLevels)
    })
}

func retrieveWorkoutTypes() {
    
    let activityLevelDB = Database.database().reference().child("Workout Types")
    
    activityLevelDB.observe(.childAdded, with: { (snapshot) in
        
        let workoutTypes = snapshot.value as! String
        
        workoutTypesArray.append(workoutTypes)
        
        print(workoutTypesArray)
    })
}



