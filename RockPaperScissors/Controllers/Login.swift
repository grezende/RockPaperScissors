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
import SCLAlertView

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
                    self.showErrorAlert(errorMessage: errorMessage!)
                    return
                }
                
                if let user = userResult {
                    PlayerProfile.shared.setId(id: user.uid)
                    RemoteDatabase.shared.getUserData(id: user.uid, completion: { (user, error) in
                        
                        if error != nil {
                            self.stopAnimating()
                            self.showErrorAlert(errorMessage: error!)
                            return
                        }
                        
                        PlayerProfile.shared.setName(name: (user!["name"] as? String)!)
                        PlayerProfile.shared.setPoints(points: user!["points"] as! Int)
                        self.stopAnimating()
                        print("Login successful!")
                        print("Id recuperado: " + PlayerProfile.shared.getId()!)
                        print("Nome recuperado: " + PlayerProfile.shared.getName()!)
                        print("Pontos recuperados: " + String(describing: PlayerProfile.shared.getPoints()))
                        self.goToHome()
                        
                    })
                }
            })
        }
        else {
            print("Needs to fill in login/pass")
            showErrorAlert(errorMessage: "Please fill in both fields")
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
                    self.showErrorAlert(errorMessage: errorMessage!)
                    return
                }
                
                if let user = userResult {
                    PlayerProfile.shared.setId(id: user.uid)
                    PlayerProfile.shared.setPoints(points: 0)
                    PlayerProfile.shared.setName(name: usernameText)
                    RemoteDatabase.shared.addNewUser(id: user.uid, name: usernameText)
                    self.stopAnimating()
                    print("Registration successful!")
                    self.goToHome()
                }
            })
        }
        else {
            print("Needs to fill in login/pass/username")
            showErrorAlert(errorMessage: "Please fill in all the fields")
        }
    }
    
    private func goToHome() {
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [Home()]
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func showErrorAlert (errorMessage: String) {
        SCLAlertView().showError("Oops!", subTitle: errorMessage)
    }
}
