//
//  WorkoutLocation.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/5/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import UIKit
import MapKit

class WorkoutLocation: NSObject, MKAnnotation {
    var identifier = "Workout Location"
    var title: String?
    var coordinate: CLLocationCoordinate2D
    init(name:String,lat:CLLocationDegrees,long:CLLocationDegrees){
        title = name
        coordinate = CLLocationCoordinate2DMake(lat, long)
    }
}
    
class WorkoutLocationList: NSObject {
    var workout = [WorkoutLocation]()
    override init(){
        
    }
}
