//
//  FilterViewController.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/12/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Variables
    
    var selectedWorkoutType : String? = ""
    var selectedActivityLevel : String? = ""
    var workoutList = kWorkoutList_KEY
    var filteredWorkouts = [WorkoutLocation]()
    var filteredWorkoutsList = [WorkoutLocation]()
    
    
    // IB Outlets
    
    @IBOutlet weak var workoutTypePicker: UIPickerView!
    @IBOutlet weak var activityLevelPicker: UIPickerView!
    @IBOutlet weak var durationSliderTextField: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false

        // Do any additional setup after loading the view.
        workoutTypePicker.delegate = self
        workoutTypePicker.dataSource = self
        activityLevelPicker.delegate = self
        activityLevelPicker.dataSource = self
        
        durationSliderTextField.text = "0"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func durationSlider(_ sender: Any) {
        durationSliderTextField.text = round(durationSlider.value).cleanValue
    }
    
    // Delegate Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == workoutTypePicker {
            return workoutTypesArray.count
        } else {
            return activityLevels.count
        }
    }
    
    // Place The Data In The Picker
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == workoutTypePicker {
            return workoutTypesArray[row]
        } else {
            return activityLevels[row]
        }
    }
    
    // Capture The Selected State
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == workoutTypePicker {
            selectedWorkoutType = workoutTypesArray[row]
        } else {
            selectedActivityLevel = activityLevels[row]
        }
        
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        kfilteredWorkoutList_KEY = kWorkoutList_KEY
        navigationController?.popViewController(animated: true)
        
        if (selectedWorkoutType != nil && selectedWorkoutType != "Select Workout Type") {
            for workout in workoutList {
                if (workout.workoutType == selectedWorkoutType) {
                    filteredWorkoutsList.append(workout)
                    print("Activity Type: ", workout.workoutType, workout.activityLevel)
                }
            }
        }
        
        if (selectedActivityLevel != nil && selectedWorkoutType != "Select Activity Level") {
            for workout in workoutList {
                if (workout.activityLevel == selectedActivityLevel) {
                    filteredWorkoutsList.append(workout)
                    print("Activity Level", workout.activityLevel, workout.workoutType)
                }
            }
        }
        
        if (selectedActivityLevel != "" && selectedActivityLevel != "Select Activity Level") && (selectedWorkoutType != "" && selectedWorkoutType != "Select Workout Type") {
            filteredWorkouts = filteredWorkoutsList.filter { ($0.workoutType == selectedWorkoutType && $0.activityLevel == selectedActivityLevel)}
        }
//        else if (selectedWorkoutType != "" && selectedWorkoutType != "Select Workout Type") {
//            filteredWorkouts = filteredWorkoutsList.filter { ($0.workoutType == selectedWorkoutType) }
//        }
        else  {
            print("Using This Filter")
            filteredWorkouts = filteredWorkoutsList.filter { ($0.activityLevel == selectedActivityLevel) || ($0.workoutType == selectedWorkoutType)}
        }
        
        for workout in filteredWorkouts {
            print("Activity Level: ", workout.activityLevel, "Workout Type: ", workout.workoutType)
        }
            
        kfilteredWorkoutList_KEY = filteredWorkouts
        
        
        selectedWorkoutType = ""
        selectedActivityLevel = ""
    }
    
    @IBAction func clearFilterButtonPressed(_ sender: Any) {
        kfilteredWorkoutList_KEY = kWorkoutList_KEY
    }
    
    
}


