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
    private var player1: String?
    private var player2: String?
    private var selectionPlayer1: String?
    private var selectionPlayer2: String?
    
    private init() {}
    
    func setId (id: String) {
        self.id = id
    }
    
    func setPlayer1 (player: String) {
        self.player1 = player
    }
    
    func setPlayer2 (player: String) {
        self.player2 = player
    }
    
    func setSelectionPlayer1 (selection: String) {
        self.selectionPlayer1 = selection
    }
    
    func setSelectionPlayer2 (selection: String) {
        self.selectionPlayer2 = selection
    }
    
    func getId () -> String? {
        return self.id
    }
    
    func getPlayer1 () -> String? {
        return self.player1
    }
    
    func getPlayer2 () -> String? {
        return self.player2
    }
    
    func getSelectionPlayer1 () -> String? {
        return self.selectionPlayer1
    }
    
    func getSelectionPlayer2 () -> String? {
        return self.selectionPlayer2
    }
    
    
}
