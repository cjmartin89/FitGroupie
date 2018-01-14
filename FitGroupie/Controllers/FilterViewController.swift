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
    
    var selectedWorkoutType = ""
    var selectedActivityLevel = ""
    
    // IB Outlets
    
    @IBOutlet weak var workoutTypePicker: UIPickerView!
    @IBOutlet weak var activityLevelPicker: UIPickerView!
    @IBOutlet weak var durationSliderTextField: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
}


