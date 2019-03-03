//
//  RemoteDatabase.swift
//  RockPaperScissors
//
//  Created by Gabriel Rezende on 02/03/19.
//  Copyright © 2019 Gabriel Rezende. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class RemoteDatabase {
    
    static let shared = RemoteDatabase()
    
    var ref: DatabaseReference!
    
    init() {
        self.ref = Database.database().reference()
    }
    
    func addNewUser (id: String, name: String) {
        
        self.ref.child("players").child(id).setValue(["name": name, "points": 0])
    }
    
    func getUserData (id: String, completion: @escaping (_: NSDictionary?, _: String?) -> ()) {
        
        self.ref.child("players").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            return completion(value, nil)
        })
        { (error) in
            print("Error retrieving user data: " + error.localizedDescription)
            return completion(nil, error.localizedDescription)
        }
    }
    
}
