//
//  Game.swift
//  RockPaperScissors
//
//  Created by Gabriel Rezende on 03/03/19.
//  Copyright © 2019 Gabriel Rezende. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Game: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimating(type: NVActivityIndicatorType.ballTrianglePath)
        
        RemoteDatabase.shared.getUserData(id: Match.shared.getOpponent()!) { (user, error) in
            
            self.player2NameLabel.text = user!["name"] as? String
            
            self.player1NameLabel.text = PlayerProfile.shared.getName()
            
            self.stopAnimating()
            
            RemoteDatabase.shared.getMatchSelections(isPlayer1: Match.shared.getIsPlayer1()!, completion: { (opponentSelection) in
                
                print(opponentSelection)
            })
        }
    }
    
    @IBAction func rockButtonClicked(_ sender: Any) {
        
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        RemoteDatabase.shared.setPlayerSelection(isPlayer1: Match.shared.getIsPlayer1()!, matchId: Match.shared.getId()!, selection: "rock")
    }
    
    @IBAction func paperButtonClicked(_ sender: Any) {
        
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        RemoteDatabase.shared.setPlayerSelection(isPlayer1: Match.shared.getIsPlayer1()!, matchId: Match.shared.getId()!, selection: "paper")
    }
    
    @IBAction func scissorsButtonClicked(_ sender: Any) {
        
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        RemoteDatabase.shared.setPlayerSelection(isPlayer1: Match.shared.getIsPlayer1()!, matchId: Match.shared.getId()!, selection: "scissors")
    }
}
