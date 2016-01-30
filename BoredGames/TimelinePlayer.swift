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
    
    private let vcIdentifier = "TimelinePlayerVC"
    
    func giveHand(newHand: TimelineHand){
        self.hand = newHand
    }
    
    override func setup() {
        self.socket.on("connect") {data, ack in
            print("Player socket connected")
            
            let codeObj = JSON([
                "id": "TestPlayerID", //self.id,
                "room": self.room
                ])
            
            let code = "\(codeObj)"
            
            self.socket.emit("JOIN_ROOM", code)
        }
        
        self.socket.on("message") {data, ack in
            print("Data: \(data)")
            
            let msg = JSON.parse(data[0] as! String)
            
            print("Message: \(msg)")
            
            // Parse message from player perspective
        }
        
        self.socket.connect()
        print("Game socket started")
    }
    
    override func getPlayerViewController() -> PlayerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifier) as! UINavigationController
        
        let tlvc = vc.viewControllers[0] as! PlayerHandVC
        
        vc.player = self
        
        return vc
    }
    
}