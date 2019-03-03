//
//  Home.swift
//  RockPaperScissors
//
//  Created by Gabriel Rezende on 02/03/19.
//  Copyright © 2019 Gabriel Rezende. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Home: UIViewController, UITableViewDelegate, UITableViewDataSource,
                NVActivityIndicatorViewable {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var leaderboardTableView: UITableView!
    
    var topNamesArray: [String]? = nil
    var topPointsArray: [Int]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimating(type: NVActivityIndicatorType.ballTrianglePath)
        
        self.leaderboardTableView.dataSource = self
        self.leaderboardTableView.delegate = self
        
        playerNameLabel.text! = PlayerProfile.shared.getName()!
        
        RemoteDatabase.shared.getToptenScores(completion: { (names, points) in
            
            self.topNamesArray = names.reversed()
            self.topPointsArray = points.reversed()
            self.leaderboardTableView.reloadData()
            
            self.stopAnimating()
        })
    }
    
// TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if let namesArray = self.topNamesArray, indexPath.row < namesArray.count {
            cell.textLabel?.text = namesArray[indexPath.row]
        }
        
        if let pointsArray = self.topPointsArray, indexPath.row < pointsArray.count {
            let label = UILabel.init(frame: CGRect(x:0,y:0,width:100,height:20))
            label.text = String(pointsArray[indexPath.row])
            cell.accessoryView = label
        }
        
        return cell
    }
}


