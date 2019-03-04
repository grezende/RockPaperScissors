//
//  Game.swift
//  RockPaperScissors
//
//  Created by Gabriel Rezende on 03/03/19.
//  Copyright © 2019 Gabriel Rezende. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SCLAlertView

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
                
                self.compareSelections(opponentSelection: opponentSelection)
            })
        }
    }
    
    func compareSelections (opponentSelection: String) {
        if opponentSelection == "rock" {
            if Match.shared.getSelectionPlayer() == opponentSelection {
                self.resolveDraw()
            }
            else {
                Match.shared.getSelectionPlayer() == "scissors" ?
                    self.resolveDefeat() : self.resolveVictory()
            }
        }
        
        if opponentSelection == "paper" {
            if Match.shared.getSelectionPlayer() == opponentSelection {
                self.resolveDraw()
            }
            else {
                Match.shared.getSelectionPlayer() == "rock" ?
                    self.resolveDefeat() : self.resolveVictory()
            }
        }
        
        if opponentSelection == "scissors" {
            if Match.shared.getSelectionPlayer() == opponentSelection {
                self.resolveDraw()
            }
            else {
                Match.shared.getSelectionPlayer() == "paper" ?
                    self.resolveDefeat() : self.resolveVictory()
            }
        }
    }
    
    func resolveVictory () {
        
        let newPoints = PlayerProfile.shared.getPoints()! + 1
        
        PlayerProfile.shared.setPoints(points: newPoints)
        
        RemoteDatabase.shared.increasePlayerScore(playerId: PlayerProfile.shared.getId()!,
                                                  points: newPoints)
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance)
        
        alert.addButton("Ok") {
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.showSuccess("Victory!", subTitle: "Your points: " + String(newPoints))
    }
    
    func resolveDefeat () {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance)
        
        alert.addButton("Ok") {
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.showNotice("Defeat...", subTitle: "Better luck next time!")
    }
    
    func resolveDraw () {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance)
        
        alert.addButton("Ok") {
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.showNotice("Draw", subTitle: "Better luck next time!")
    }
    
    @IBAction func rockButtonClicked(_ sender: Any) {
        
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        RemoteDatabase.shared.setPlayerSelection(isPlayer1: Match.shared.getIsPlayer1()!, matchId: Match.shared.getId()!, selection: "rock")
        Match.shared.setSelectionPlayer1(selection: "rock")
    }
    
    @IBAction func paperButtonClicked(_ sender: Any) {
        
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        RemoteDatabase.shared.setPlayerSelection(isPlayer1: Match.shared.getIsPlayer1()!, matchId: Match.shared.getId()!, selection: "paper")
        Match.shared.setSelectionPlayer1(selection: "paper")
    }
    
    @IBAction func scissorsButtonClicked(_ sender: Any) {
        
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        RemoteDatabase.shared.setPlayerSelection(isPlayer1: Match.shared.getIsPlayer1()!, matchId: Match.shared.getId()!, selection: "scissors")
        Match.shared.setSelectionPlayer1(selection: "scissors")
    }
}
