//
//  WorkoutDetailViewController.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/13/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController {

    var workoutAddress = ""
    var workoutName = ""
    var workoutType = ""
    var workoutDuration = 0
    var activityLevel = ""
    var workoutDate = Date()
    
    //IB Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var workoutTypeLabel: UILabel!
    @IBOutlet weak var workoutDurationLabel: UILabel!
    @IBOutlet weak var activityLevelLabel: UILabel!
    @IBOutlet weak var AddressContainerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = "\(workoutName)"
        AddressContainerLabel.text = "\(workoutAddress)"
        workoutTypeLabel.text = "Workout Type: \(workoutType)"
        workoutDurationLabel.text = "Workout Duration: \(String(workoutDuration))"
        activityLevelLabel.text = "Activity Level: \(activityLevel)"
        
    }
    
    

}
