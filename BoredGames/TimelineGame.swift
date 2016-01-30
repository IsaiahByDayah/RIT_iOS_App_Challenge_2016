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
    
    convenience init() {
        self.init(deck: TimelineDeckAmericanHistory())
    }
    
    override func setup() {
        self.socket.on("connect") {data, ack in
            print("Game socket connected")
            
            let codeObj = JSON([
                "id": "TestGameID", //self.id,
                "title": self.title
                ])
            
            let code = "\(codeObj)"
            
            self.socket.emit("createRoom", code)
        }
        
        self.socket.on("message") {data, ack in
            print("Data: \(data)")
            
            let msg = JSON.parse(data as! String)
            
            print("Message: \(msg)")
        }
        
        self.socket.connect()
        print("Game socket started")
    }
    
    override func getGameViewController() -> GameViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifier) as! TimelineGameViewController
        
        vc.game = self
        
        return vc
    }
}