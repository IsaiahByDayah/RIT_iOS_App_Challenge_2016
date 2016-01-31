//
//  TimelinePlayer.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class TimelinePlayer: Player {
    
    var hand: TimelineHand!
    
    private let vcIdentifier = "TimelinePlayerScannedViewController"
    
    func giveHand(newHand: TimelineHand){
        self.hand = newHand
    }
    
    override func setup() {
        self.socket.on("connect") {data, ack in
            print("Player socket connected")
            
            let data = [
                "type": "JOIN_ROOM",
                "room": self.room,
                "from": self.id,
                "to": "Game"
            ]
            
            self.socket.emit("JOIN_ROOM", data)
        }
        
        self.socket.on("MESSAGE") {data, ack in
            print("Data: \(data)")
            
            let msg = JSON.parse(data[0] as! String)
            
            print("Message: \(msg)")
            
            // Parse message from player perspective
        }
        
        self.socket.connect()
        print("Game socket started")
    }
    
    override func tearDown() {
        self.socket.disconnect()
    }
    
    override func getPlayerViewController() -> PlayerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifier) as! TimelinePlayerScannedViewController
        
        vc.player = self
        
        return vc
    }
    
}