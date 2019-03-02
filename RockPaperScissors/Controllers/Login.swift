//
//  Login.swift
//  RockPaperScissors
//
//  Created by Gabriel Rezende on 02/03/19.
//  Copyright © 2019 Gabriel Rezende. All rights reserved.
//

import UIKit
import FirebaseAuth
import IHKeyboardAvoiding
import NVActivityIndicatorView

class Login: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KeyboardAvoiding.avoidingView = self.view
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        
        startAnimating(type: NVActivityIndicatorType.ballTrianglePath)
        
        if let loginText = loginField.text, !loginText.isEmpty,
            let passText = passwordField.text, !passText.isEmpty {
            
            Auth.auth().signIn(withEmail: loginText, password: passText) { (authResult, error) in
                
                if let error = error {
                    print("Erro na autenticação: " + error.localizedDescription)
                    self.stopAnimating()
                    return
                }
                
                if let user = authResult?.user {
                    PlayerProfile.shared.setId(id: user.uid)
                    // Query for player data using Id.
                }
            }
        }
    }
}
