//
//  PlayerProfile.swift
//  RockPaperScissors
//
//  Created by Gabriel Rezende on 02/03/19.
//  Copyright © 2019 Gabriel Rezende. All rights reserved.
//

import Foundation

class PlayerProfile {
    
    static let shared = PlayerProfile()
    
    var id: String?
    var name: String?
    var points: Int?
    
    private init() {}
    
    public func setId (id: String) {
        self.id = id
    }
    
    public func setName (name: String) {
        self.name = name
    }
    
    public func setPoints (points: Int) {
        self.points = points
    }
    
    public func getId () -> String? {
        return self.id
    }
    
    public func getName () -> String? {
        return self.name
    }
    
    public func getPoints () -> Int? {
        return self.points
    }
}
