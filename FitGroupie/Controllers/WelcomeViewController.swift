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
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        
        logInButton.layer.cornerRadius = signUpButton.frame.height / 2
        
        facebookLogin.layer.cornerRadius = facebookLogin.frame.height / 2
    }


}
