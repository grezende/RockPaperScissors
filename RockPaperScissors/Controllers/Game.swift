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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimating(type: NVActivityIndicatorType.ballTrianglePath)
        
        RemoteDatabase.shared.getUserData(id: Match.shared.getOpponent()!) { (user, error) in
            
            self.player2NameLabel.text = user!["name"] as? String
            
            self.stopAnimating()
        }
        
        
        
        player1NameLabel.text = PlayerProfile.shared.getName()
    }

}
