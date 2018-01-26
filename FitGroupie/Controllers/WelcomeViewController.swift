//
//  WelcomeViewController.swift
//  FitGroupie
//
//  Created by Chris Martin on 1/11/18.
//  Copyright © 2018 Martin Technical Solutions. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //IB Outlets
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var facebookLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.isHidden = true
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        
        logInButton.layer.cornerRadius = signUpButton.frame.height / 2
        
        facebookLogin.layer.cornerRadius = facebookLogin.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor(red: 252/255, green: 207/255, blue: 77/255, alpha: 1.0)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 252/255, green: 207/255, blue: 77/255, alpha: 1.0)]
    }
    
    

}
