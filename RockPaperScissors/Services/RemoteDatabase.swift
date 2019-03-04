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
                
                self.ref.child("matches").child(matchId).child("player2")
                    .setValue(PlayerProfile.shared.getId())
                
                Match.shared.setId(id: matchId)
                Match.shared.setOpponent(player: firstMatch.childSnapshot(forPath: "player1")
                    .value as! String)
                Match.shared.setPlayer(player: PlayerProfile.shared.getId()!)
                Match.shared.setIsPlayer1(isPlayer1: false)
                
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
                
                Match.shared.setId(id: matchId.key!)
                Match.shared.setPlayer(player: PlayerProfile.shared.getId()!)
                Match.shared.setIsPlayer1(isPlayer1: true)
                
                self.ref.child("matches").child(matchId.key!).child("player2")
                    .observe(DataEventType.value, with: { (snapshot) in
                
                        let opponent = snapshot.value as? String
                        
                        if opponent != "none" {
                            Match.shared.setOpponent(player: opponent!)
                            completion(nil, matchId.key)
                        }
                })
            }
        })
    }
    
    func getMatchSelections (isPlayer1: Bool, completion: @escaping (_: String) -> ()) {
        
        ref.child("matches").child(Match.shared.getId()!).observe(DataEventType.value, with: { (snapshot) in
            
            let matchData = snapshot.value as? NSDictionary
            
            if matchData!["selectionPlayer1"] as? String != "none" &&
                matchData!["selectionPlayer2"] as? String != "none" {
                
                if !isPlayer1 {
                    completion((matchData!["selectionPlayer1"] as? String)!)
                }
                else {
                    completion((matchData!["selectionPlayer2"] as? String)!)
                }
            }
        })
    }
    
    func setPlayerSelection (isPlayer1: Bool, matchId: String, selection: String) {
        
        ref.child("matches").child(matchId).child(isPlayer1 ?
            "selectionPlayer1" : "selectionPlayer2").setValue(selection)
    }
    
    func increasePlayerScore (playerId: String, points: Int) {
        
        ref.child("players").child(playerId).child("points").setValue(points)
    }
}
