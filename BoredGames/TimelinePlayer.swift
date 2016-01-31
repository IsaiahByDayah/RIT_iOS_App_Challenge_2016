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
    
    var timelinePlayerScanCompleteDelegate: TimelinePlayerScanCompleteDelegate?
    var timelinePlayerDelegate: TimelinePlayerDelegate?
    
    private let vcIdentifier = "TimelinePlayerScannedViewController"
    
    func giveHand(newHand: TimelineHand){
        self.hand = newHand
    }
    
    override func setup() {
        self.socket.on("connect") {data, ack in
            print("Player socket connected")
        }
        
        self.socket.on("MESSAGE") {data, ack in
            print("Data: \(data)")
            
            let msg = JSON.parse(data[0] as! String)
            
            print("Message: \(msg)")
            
            // Parse message from player perspective
            
            switch msg["type"].stringValue{
            case "CONNECT_INFO":
                
                self.socketID = msg["socketID"].stringValue
                
                let data = [
                    "type": "JOIN_ROOM",
                    "room": self.room,
                    "from": self.getFromSelf(),
                    "to": Utilities.Constants.get("ServerRole") as! String
                ]
                
                self.socket.emit("JOIN_ROOM", data)
                break
                
            case "MESSAGE":
                switch msg["from"]["role"].stringValue {
                case Utilities.Constants.get("GameRole") as! String:
                    print("Got a message from the server")
                    // Handle message from game
                    
                    break
                default:
                    print("Message was not from game. Ignoring...")
                    break
                }
                break
                
            default:
                print("Unknown Message Recieved. Ignoring...")
                break
            }
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

protocol TimelinePlayerScanCompleteDelegate {
    func gameStarted()
}

protocol TimelinePlayerDelegate {
    func gameUpdated()
}