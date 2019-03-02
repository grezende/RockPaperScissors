//
//  Login.swift
//  RockPaperScissors
//
//  Created by Gabriel Rezende on 02/03/19.
//  Copyright © 2019 Gabriel Rezende. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding
import NVActivityIndicatorView

class Login: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KeyboardAvoiding.avoidingView = self.view
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        
        if let loginText = loginField.text, !loginText.isEmpty,
            let passText = passwordField.text, !passText.isEmpty {
            
            startAnimating(type: NVActivityIndicatorType.ballTrianglePath)
            
            Authentication.shared.loginUser(email: loginText, password: passText, completion:  { (userResult, errorMessage) in
                
                if errorMessage != nil {
                    self.stopAnimating()
                    // TODO: Show alert
                    return
                }
                
                if let user = userResult {
                    PlayerProfile.shared.setId(id: user.uid)
                    // TODO: Query for player data using Id.
                    self.stopAnimating()
                    print("Login successful!")
                }
            })
        }
        else {
            print("Needs to fill in login/pass")
            // TODO: Show Alert
        }
    }
    @IBAction func registerButtonClicked(_ sender: Any) {
        
        if let loginText = loginField.text, !loginText.isEmpty,
            let passText = passwordField.text, !passText.isEmpty,
            let usernameText = usernameField.text, !usernameText.isEmpty{
        
            startAnimating(type: NVActivityIndicatorType.ballTrianglePath)
            
            Authentication.shared.registerUser(email: loginText, password: passText, completion: { (userResult, errorMessage) in
                
                if errorMessage != nil {
                    self.stopAnimating()
                    // TODO: Show alert
                    return
                }
                
                if let user = userResult {
                    PlayerProfile.shared.setId(id: user.uid)
                    PlayerProfile.shared.setPoints(points: 0)
                    PlayerProfile.shared.setName(name: usernameText)
                    self.stopAnimating()
                    print("Registration successful!")
                }
            })
        }
        else {
            print("Needs to fill in login/pass/username")
            // TODO: Show Alert
        }
    }
}
