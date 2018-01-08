//
//  Workout.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/6/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import Foundation
import MapKit

class Workout {
    
    var workoutName : String = ""
    var workoutType : String = ""
    var workoutAddress : String = ""
    var workoutDate : Date
    
    init(Name:String,Address:String, Type:String, Date: Date){
        workoutName = Name
        workoutAddress = Address
        workoutType = Type
        workoutDate = Date
    }
    
}
