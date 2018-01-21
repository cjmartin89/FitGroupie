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
    
    var isSearching = false
    var workoutIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        workoutsSearchBar.delegate = self
        workoutsSearchBar.returnKeyType = UIReturnKeyType.done
        workoutsTableView.delegate = self
        workoutsTableView.dataSource = self
        workoutsTableView.reloadData()
        
        workoutArray = kWorkoutList_KEY
    }
    
    //    MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text : String!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        if self.isSearching {
            cell.textLabel?.text = workoutArray[indexPath.row].title!
            cell.detailTextLabel?.text = workoutArray[indexPath.row].workoutType
        } else {
            cell.textLabel?.text = workoutArray[indexPath.row].title!
            cell.detailTextLabel?.text = workoutArray[indexPath.row].workoutType
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return workoutArray.count
        }
        
        return workoutArray.count
    }
    
    //Set up cell context actions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "workoutDetailSegue", sender: self)
        workoutsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "workoutDetailSegue" {
            let workoutDetailViewController = segue.destination as! WorkoutDetailViewController
            if let indexPath = self.workoutsTableView.indexPathForSelectedRow {
                workoutDetailViewController.workoutName = workoutArray[indexPath.row].title!
                workoutDetailViewController.workoutAddress = workoutArray[indexPath.row].workoutAddress
                workoutDetailViewController.workoutType = workoutArray[indexPath.row].workoutType
                workoutDetailViewController.workoutDuration = workoutArray[indexPath.row].workoutDuration
                workoutDetailViewController.activityLevel = workoutArray[indexPath.row].activityLevel
            }
        }
        
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
