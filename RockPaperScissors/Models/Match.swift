//
//  Match.swift
//  RockPaperScissors
//
//  Created by Gabriel Rezende on 03/03/19.
//  Copyright © 2019 Gabriel Rezende. All rights reserved.
//

import Foundation

class Match {
    
    static let shared = Match()
    
    private var id: String?
    private var player: String?
    private var opponent: String?
    private var selectionPlayer: String?
    private var selectionOpponent: String?
    private var isPlayer1: Bool?
    
    private init() {}
    
    func setId (id: String) {
        self.id = id
    }
    
    func setPlayer (player: String) {
        self.player = player
    }
    
    func setOpponent (player: String) {
        self.opponent = player
    }
    
    func setSelectionPlayer1 (selection: String) {
        self.selectionPlayer = selection
    }
    
    func setSelectionOpponent (selection: String) {
        self.selectionOpponent = selection
    }
    
    func setIsPlayer1 (isPlayer1: Bool) {
        self.isPlayer1 = isPlayer1
    }
    
    func getId () -> String? {
        return self.id
    }
    
    func getPlayer () -> String? {
        return self.player
    }
    
    func getOpponent () -> String? {
        return self.opponent
    }
    
    func getSelectionPlayer () -> String? {
        return self.selectionPlayer
    }
    
    func getSelectionOpponent () -> String? {
        return self.selectionOpponent
    }
    
    func getIsPlayer1 () -> Bool? {
        return self.isPlayer1
    }
}
