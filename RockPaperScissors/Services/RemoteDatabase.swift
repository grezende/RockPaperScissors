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
    
    func getToptenScores (completion: @escaping (_: [String], _: [Int]) -> ()) {
        
        self.ref.child("players").queryOrdered(byChild: "points").queryLimited(toFirst: 10).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            var topTenNamesArray: [String] = []
            var toptenPointsArray: [Int] = []
            
            if snapshot.exists() {
                
                print(snapshot)
                
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let name = child.childSnapshot(forPath: "name").value as! String
                    let points = child.childSnapshot(forPath: "points").value as! Int
                    
                    topTenNamesArray.append(name)
                    toptenPointsArray.append(points)
                }
                
                completion(topTenNamesArray, toptenPointsArray)
                
            } else {
                print("Points query returned no results")
            }
        })
    }
    
    func getAvailableGame (completion: @escaping (_: String?, _: String?) -> ()) {
        
        ref.child("matches").queryOrdered(byChild: "player2").queryEqual(toValue: "none").observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {
                
                let matchId = (snapshot.value as? NSDictionary)?.allKeys[0] as! String
                let firstMatch = (snapshot.children.allObjects as! [DataSnapshot])[0]
                
                self.ref.child("matches").child(matchId).child("player1")
                    .setValue(PlayerProfile.shared.getId())
                
                Match.shared.setId(id: matchId)
                Match.shared.setPlayer1(player: firstMatch.childSnapshot(forPath: "player1")
                    .value as! String)
                Match.shared.setPlayer2(player: PlayerProfile.shared.getId()!)
                
                print(Match.shared.getPlayer1())
                print(Match.shared.getId())
                
                completion(nil, matchId)
            }
            else {
                let matchId = self.ref.child("matches").childByAutoId()
                
                let newMatch = [
                    "player1": PlayerProfile.shared.getId()!,
                    "player2": "none",
                    "selectionPlayer1": "none",
                    "selectionPlayer2": "none"
                ]
                
                self.ref.child("matches").child(matchId.key!).setValue(newMatch)
                completion(nil, matchId.key)
            }
        })
    }
}
