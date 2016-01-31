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
        
        super.init(title: Utilities.Constants.get("TimelineTitle") as! String, minPlayers: 0, maxPlayers: 5)
        
        print(self.deck)
    }
    
    convenience init() {
        self.init(deck: TimelineDeckAmericanHistory())
    }
    
    override func setup() {
        self.socket.on("connect") {data, ack in
            print("Game socket connected")
            
//            let data = [
//                "type": "JOIN_ROOM",
//                "room": self.id,
//                "from": "Game",
//                "to": "Server"
//            ]
//            
//            self.socket.emit("JOIN_ROOM", data)
        }
        
        self.socket.on("disconnect") {data, ack in
            print("Game socket disconnected")
        }
        
        self.socket.on("MESSAGE") {data, ack in
            print("Data: \(data)")
            
            let msg = JSON.parse(data[0] as! String)
            
            print("Message: \(msg)")
            
            // Parse message from player perspective
            
            if msg["type"].stringValue == "CONNECT_INFO" {
            
                let data = [
                    "type": "JOIN_ROOM",
                    "room": self.id,
                    "from": "Game",
                    "to": "Server"
                ]
                            
                self.socket.emit("JOIN_ROOM", data)
                
                return
            }
        }
        
        self.socket.connect()
        print("Game socket started")
    }
    
    override func tearDown() {
        self.socket.disconnect()
    }
    
    override func getGameViewController() -> GameViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifier) as! TimelineGameViewController
        
        vc.game = self
        
        return vc
    }
}