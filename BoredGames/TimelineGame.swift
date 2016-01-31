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
    
    var delagate: TimelineGameDalegate?
    
    private let vcIdentifier = "TimelineGameViewController"
    
    init(deck: TimelineDeck) {
        self.deck = deck
        
        super.init(title: Utilities.Constants.get("TimelineTitle") as! String, minPlayers: Utilities.Constants.get("TimelineMinPlayers") as! Int, maxPlayers: Utilities.Constants.get("TimelineMinPlayers") as! Int)
    }
    
    convenience init() {
        self.init(deck: TimelineDeckAmericanHistory())
    }
    
    func dealCards() {
        self.deck.shuffle()
    }
    
    override func setup() {
        self.socket.on("connect") {data, ack in
            print("Game socket connected")
        }
        
        self.socket.on("disconnect") {data, ack in
            print("Game socket disconnected")
        }
        
        self.socket.on("MESSAGE") {data, ack in
            print("Data: \(data)")
            
            let msg = JSON.parse(data[0] as! String)
            
            print("Message: \(msg)")
            
            // Parse message from player perspective
            
            switch msg["type"].stringValue{
                
            // MARK: Initial Connect Info
            case "CONNECT_INFO":
                
                self.socketID = msg["socketID"].stringValue
                
                let data = [
                    "type": "JOIN_ROOM",
                    "room": self.id,
                    "from": self.getFromSelf(),
                    "to": Utilities.Constants.get("ServerRole") as! String
                ]
                    
                self.socket.emit("JOIN_ROOM", data)
                break
                
            // MARK: Someone Joined The Room
            case "JOIN_ROOM":
                if msg["from"]["role"].stringValue != Utilities.Constants.get("GameRole") as! String {
                    let player = msg["from"]
                    self.addPlayer(player)
                    if let delegate = self.scanDelagate {
                        delegate.playersUpdated()
                    }
                }
                break
                
            // MARK: Message Recieved
            case "MESSAGE":
                switch msg["from"]["role"].stringValue {
                    
                // MARK: From Server
                case Utilities.Constants.get("ServerRole") as! String:
                    print("Got a message from the server")
                    // Handle message from server
                    
                    break
                    
                // MARK: From Player
                case Utilities.Constants.get("PlayerRole") as! String:
                    print("Got a message from a player")
                    // Handle message from player
                    
                    break
                    
                // MARK: From Spectator
                case Utilities.Constants.get("SpectatorRole") as! String:
                    print("Got a message from a spectator")
                    // Handle message from player
                    
                    break
                default:
                    print("Message was not from server, player, or spectator. Ignoring...")
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
    
    override func startGame() {
        let data = [
            "type": "MESSAGE",
            "room": self.id,
            "from": self.getFromSelf(),
            "to": self.getToAllPlayers(),
            "request" : [
                "action" : Utilities.Constants.get("StartGameAction") as! String
            ]
        ]
        
        self.socket.emit("JOIN_ROOM", data)
    }
    
    override func getGameViewController() -> GameViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifier) as! TimelineGameViewController
        
        vc.game = self
        self.delagate = vc
        
        return vc
    }
}

protocol TimelineGameDalegate {
    func gameUpdated()
}