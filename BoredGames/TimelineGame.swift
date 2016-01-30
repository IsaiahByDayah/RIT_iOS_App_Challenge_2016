//
//  TimelineGame.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class TimelineGame: Game {
    
    var deck: TimelineDeck
    
    private let vcIdentifier = "TimelineGameViewController"
    
    init(deck: TimelineDeck) {
        self.deck = deck
        
        super.init(title: "Timeline", minPlayers: 0, maxPlayers: 5)
        
        print(self.deck)
    }
    
    override func getGameViewController() -> GameViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifier) as! TimelineGameViewController
        
        vc.game = self
        
        return vc
    }
}