//
//  TimelinePlayer.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class TimelinePlayer: Player {
    
    var hand: TimelineHand?
    
    var currentBoard: [TimelineCard]?
    
    var timelinePlayerScanCompleteDelegate: TimelinePlayerScanCompleteDelegate?
    var timelinePlayerDelegate: TimelinePlayerDelegate?
    
    private var myTurn = false
    
    private let vcIdentifier = "TimelinePlayerScannedViewController"
    
    func giveHand(newHand: TimelineHand){
        self.hand = newHand
    }
    
    func giveCards(newCards: [TimelineCard]){
        guard let myHand = self.hand else {
            return
        }
        myHand.giveCards(newCards)
    }
    
    func canTakeTurn() -> Bool {
        return self.myTurn
    }
    
    func sendChoice(index: Int) {
        print("Trying to send card...")
        
        guard let myHand = self.hand else {
            print("Could not get hand.")
            return
        }
        
        guard let c = myHand.getSelectedCard() else {
            print("Could not get selected card.")
            return
        }
        
        let card = TimelineCard.jsonify(c)
        
        guard let json = card.rawString() else {
            print("Could not stringify card.")
            return
        }
        
        let data = [
            "type": "MESSAGE",
            "room": self.room,
            "from": self.getFromSelf(),
            "to": Utilities.Constants.get("ServerRole") as! String,
            "response" : [
                "card": json
            ]
        ]
        
        self.socket.emit("MESSAGE", data)
        print("Card sent.")
        
        guard let delegate = self.timelinePlayerDelegate else {
            print("Could not notify Delegate of game update after sending card.")
            return
        }
        
        delegate.gameUpdated()
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
            
            // MARK: Initial Connect Information
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
                
            // MARK: Message Recieved
            case "MESSAGE":
                switch msg["from"]["role"].stringValue {
                    
                // MARK: From Game
                case Utilities.Constants.get("GameRole") as! String:
                    print("Got a message from the server")
                    // Handle message from game
                    
                    switch msg["request"]["action"].stringValue {
                    
                    // MARK: Game Started
                    case Utilities.Constants.get("StartGameAction") as! String:
                        if let delegate = self.timelinePlayerScanCompleteDelegate {
                            delegate.gameStarted()
                        }
                        break
                        
                    // MARK: Board Updated
                    case Utilities.Constants.get("BoardUpdatedAction") as! String:
                        let board = msg["request"]["board"].arrayValue
                        
                        let cards = TimelineCard.parse(board)
                        
                        self.currentBoard = cards
                        
                        if let delegate = self.timelinePlayerDelegate {
                            delegate.gameUpdated()
                        }
                        break
                        
                    // MARK: Change Player Turn
                    case Utilities.Constants.get("ChangePlayerTurn") as! String:
                        let player = msg["request"]["player"]
                        
                        self.myTurn self.isMe(player)
                        break
                        
                    default:
                        print("Unknown Action Recieved. Ignoring...")
                        break
                    }
                    
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