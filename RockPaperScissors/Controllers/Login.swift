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
        
//        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//            // ...
//        }
    }
}
