//
//  AddEventViewController.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/6/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class AddEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // Constants
    
    let geoCoder = CLGeocoder()
    
    // Variable
    
    var selectedState = ""
    var selectedWorkoutType = ""
    var address = ""
    var retrievedLatitude : CLLocationDegrees?
    var retrievedLongitude : CLLocationDegrees?
    
    // IB Outlets
    
    @IBOutlet weak var workoutNameTextField: UITextField!
    @IBOutlet weak var workoutTypePicker: UIPickerView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var workoutDurationTextField: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var workoutTimePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Delegate and Data Source Declarations
        
        statePicker.delegate = self
        statePicker.dataSource = self
        workoutTypePicker.delegate = self
        workoutTypePicker.dataSource = self
        self.addressTextField.delegate = self
        self.cityTextField.delegate = self
        self.workoutNameTextField.delegate = self
        
        // Set Workout Duration Text Field Initial Value
        
        workoutDurationTextField.text = "0"
    }
    
    // IB Actions
    
    @IBAction func createWorkoutButtonPressed(_ sender: UIButton) {
        
        geoCoder.geocodeAddressString(getAddress()) { (placemarks, error) in
            // Process Response
            let coordinates = self.processResponse(withPlacemarks: placemarks, error: error)
            print(coordinates)
            self.retrievedLongitude = coordinates.longitude
            print(self.retrievedLongitude!)
            self.retrievedLatitude = coordinates.latitude
            print(self.retrievedLatitude!)
        }
        
        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            
            print(self.retrievedLatitude ?? 0.00, self.retrievedLongitude ?? 0.00)
            
            //TODO: Send the message to Firebase and save it in our database
            
            let workoutDB = Database.database().reference().child("Workouts")
            
            let workoutDictionary = ["Workout Name" : self.workoutNameTextField.text!,
                                     "Workout Type" : self.selectedWorkoutType,
                                     "Workout Address" : self.address,
                                     "Workout Time" : String(describing: self.workoutTimePicker.date),
                                     "Workout Duration" : self.durationSlider.value,
                                     "Latitude" : self.retrievedLatitude!,
                                     "Longitude" : self.retrievedLongitude!
                ] as [String : Any]
            workoutDB.childByAutoId().setValue(workoutDictionary) {
                (error, ref) in
                
                if error != nil {
                    print(error!)
                }
                else {
                    print("Workout saved successfully")

                }
            }
            
            self.workoutNameTextField.text = ""
            self.addressTextField.text = ""
            self.cityTextField.text = ""
            self.durationSlider.value = 0
            self.workoutDurationTextField.text = "0"
        }
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func durationSliderValueChanged(_ sender: Any) {
        
        workoutDurationTextField.text = round(durationSlider.value).cleanValue
        
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func getAddress() -> String {
        
        address = addressTextField.text! + "," + cityTextField.text! + "," + selectedState
        
        return address
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) -> (latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        // Update View
        var latitude : CLLocationDegrees?
        var longitude : CLLocationDegrees?
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                latitude = coordinate.latitude
                longitude = coordinate.longitude
            } else {
                print("No Matching Location Found")
            }
        }
        return (latitude!, longitude!)
    }

    
    // Delegate Methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePicker {
            return states.count
        } else {
            return workoutTypes.count
        }
    }
    
    // Place The Data In The Picker
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statePicker {
            return states[row]
        } else {
            return workoutTypes[row]
        }
    }
    
    // Capture The Selected State
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePicker {
            selectedState = states[row]
        } else {
            selectedWorkoutType = workoutTypes[row]
        }
        
    }
}

// Remove Empty Decimal Spaces

extension Float {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
