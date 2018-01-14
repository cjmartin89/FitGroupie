//
//  ListViewController.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/12/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreLocation

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // IB Outlets
    
    @IBOutlet weak var workoutsSearchBar: UISearchBar!
    @IBOutlet weak var workoutsTableView: UITableView!
    
    // Variables
    
    var filteredWorkouts = [Workout]()
    var isSearching = false
    var workoutIndex : Int = 0
    var workoutArray = [Workout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        workoutsSearchBar.delegate = self
        workoutsSearchBar.returnKeyType = UIReturnKeyType.done
        workoutsTableView.delegate = self
        workoutsTableView.dataSource = self
        
        retrieveWorkouts()
        print(workoutArray)
        
    }
    
    //    MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text : String!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        if self.isSearching {
            cell.textLabel?.text = self.filteredWorkouts[indexPath.row].workoutName
            cell.detailTextLabel?.text = self.filteredWorkouts[indexPath.row].workoutType
        } else {
            cell.textLabel?.text = workoutArray[indexPath.row].workoutName
            cell.detailTextLabel?.text = workoutArray[indexPath.row].workoutType
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredWorkouts.count
        }
        
        return workoutArray.count
    }
    
    //Set up cell context actions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateQuoteSegue", sender: self)
        workoutsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func retrieveWorkouts() {
        
        let workoutDB = Database.database().reference().child("Workouts")
        
        workoutDB.observe(.childAdded, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, Any>
            
            let workoutName = snapshotValue["Workout Name"]!
            let workoutAddress = snapshotValue["Workout Address"]!
            let workoutTime = snapshotValue["Workout Time"]!
            let workoutType = snapshotValue["Workout Type"]
            let workoutDuration = snapshotValue["Workout Duration"]
            
            print(workoutName, workoutAddress, workoutTime, workoutType!, workoutDuration!)
            
            let workout = Workout(Name: workoutName as! String, Address: workoutAddress as! String, Type: workoutType as! String, Date: Date.init())
            self.workoutArray.append(workout)
        })
    }
    
    // Search Bar Setup
    
//    func searchBar(_ quotesSearchBar : UISearchBar, textDidChange: String) {
//        if quotesSearchBar.text == nil || quotesSearchBar.text == "" {
//            isSearching = false
//            quotesTableView.reloadData()
//        } else {
//            isSearching = true
//            self.quotesSearchBar.showsCancelButton = true
//            let lower = quotesSearchBar.text!.lowercased()
//            filteredQuotes = quotesArray.filter({$0.Person.lowercased().hasPrefix(lower)})
//            quotesTableView.reloadData()
//        }
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        quotesSearchBar.resignFirstResponder() // hides the keyboard.
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        // Stop doing the search stuff
//        // and clear the text in the search bar
//        searchBar.text = ""
//        // Hide the cancel button
//        searchBar.showsCancelButton = false
//        // You could also change the position, frame etc of the searchBar
//        retrieveQuotes(url: "http://18.220.140.97:8080/api/quotes/")
//        quotesSearchBar.resignFirstResponder()
//    }

}
