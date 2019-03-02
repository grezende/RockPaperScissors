//
//  Authentication.swift
//  RockPaperScissors
//
//  Created by Gabriel Rezende on 02/03/19.
//  Copyright © 2019 Gabriel Rezende. All rights reserved.
//

import Foundation
import FirebaseAuth

class Authentication {
    
    static let shared = Authentication()
    
    private init() {}
    
    public func loginUser(email: String, password: String, completion: @escaping (_: User?, _: String?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
        
            if let error = error {
                print("Authentication Error: " + error.localizedDescription)
                return completion(nil, error.localizedDescription)
            }
            
            if let user = authResult?.user {
                return completion(user, nil)
            }
        }
    }
    
    public func registerUser(email: String, password: String, completion: @escaping (_: User?, _: String?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if let error = error {
                print("Registration Error: " + error.localizedDescription)
                return completion(nil, error.localizedDescription)
            }
            
            if let user = authResult?.user {
                return completion(user, nil)
            }
        }
    }
}
