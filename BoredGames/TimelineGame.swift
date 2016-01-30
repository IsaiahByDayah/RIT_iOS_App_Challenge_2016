//
//  TimelineGame.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import Foundation

class TimelineGame: Game {
    
    var deck: TimelineDeck
    
    init(deck: TimelineDeck) {
        self.deck = deck
        
        super.init(title: "Timeline", minPlayers: 0, maxPlayers: 5)
        
        print(self.deck)
    }
}