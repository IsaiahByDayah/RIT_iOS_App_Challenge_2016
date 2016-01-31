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
        if self.hand == nil {
            print("Hand does not exist when given cards, creating hand")
            self.hand = TimelineHand(cards: newCards)
            return
        }
        
        self.hand!.giveCards(newCards)
    }
    
    func canTakeTurn() -> Bool {
        return self.myTurn
    }
    
    func sendChoice(index: Int) {
        print("Trying to send card...")
        
        guard let myHand = self.hand else {
            print("Could not get hand when sending choice.")
            return
        }
        
        guard let c = myHand.getSelectedCard() else {
            print("Could not get selected card.")
            return
        }
        
        let card = c.toJSON()
        
        guard let json = card.rawString() else {
            print("Could not stringify card.")
            return
        }
        
        //json = json.stringByReplacingOccurrencesOfString("\n", withString: "")
        //json = json.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        let data = [
            "type": "MESSAGE",
            "room": self.room,
            "from": self.getFromSelf(),
            "to": Utilities.Constants.get("GameRole") as! String,
            "response" : [
                "action" : Utilities.Constants.get("PlayCardAction") as! String,
                "card": json,
                "index": index
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
    
    func didWin() -> Bool {
        guard let myHand = self.hand else {
            print("Could not get hand, returning did not win.")
            return false
        }
        
        if myHand.cards.count == 0 {
            return true
        }
        
        return false
    }
    
    override func setup() {
        self.socket.on("connect") {data, ack in
            print("Player socket connected")
        }
        
        self.socket.on("MESSAGE") {data, ack in
            // print("Data: \(data)")
            
            let msg = data[0] as! NSDictionary
            
            // print("Message: \(msg)")
            
            // Parse message from player perspective
            
            switch msg["type"] as! String {
            
            // MARK: Initial Connect Information
            case "CONNECT_INFO":
                
                if self.socketID != nil {
                    print("NOTE: Trying to set self.socketID again but won't let it.")
                    return
                }
                
                self.socketID = msg["socketID"] as! String
                
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
                let from = msg["from"] as! NSDictionary
                
                switch from["role"] as! String {
                    
                // MARK: From Game
                case Utilities.Constants.get("GameRole") as! String:
                    print("Got a message from the server")
                    // Handle message from game
                    
                    let req = msg["request"] as! NSDictionary
                    
                    switch req["action"] as! String {
                    
                    // MARK: Game Started
                    case Utilities.Constants.get("StartGameAction") as! String:
                        if let delegate = self.timelinePlayerScanCompleteDelegate {
                            delegate.gameStarted()
                        }
                        break
                        
                    // MARK: Game Ended
                    case Utilities.Constants.get("EndGameAction") as! String:
                        if let delegate = self.timelinePlayerDelegate {
                            //Utilities.Flow.run(1.0, closure: { () -> () in
                                delegate.gameEnded(self.didWin())
                            //})
                        }
                        break
                        
                    // MARK: Board Updated
                    case Utilities.Constants.get("BoardUpdatedAction") as! String:
                        let board = req["board"] as! String
                        
                        let boardJSON = JSON.parse(board).arrayValue
                        
                        let cards = TimelineCard.parse(boardJSON)
                        
                        self.currentBoard = cards
                        
                        print("Current Board From Game: \(self.currentBoard)")
                        
                        if let delegate = self.timelinePlayerDelegate {
                            delegate.gameUpdated()
                        }
                        break
                        
                    // MARK: Beginning Hand
                    case Utilities.Constants.get("BeginingHandAction") as! String:
                        let to = msg["to"] as! NSDictionary
                        let toJSON = Utilities.Convert.fromPlayerDictionaryToJSON((to))
                        
                        if self.isMe(toJSON) {
                            let hand = req["hand"] as! String
                            
                            print("\n\nBeginning Hand (String): \(hand)\n\n")
                            
                            let handJSON = JSON.parse(hand).arrayValue
                            
                            print("\n\nBeginning Hand (JSON): \(handJSON)\n\n")
                            
                            let cards = TimelineCard.parse(handJSON)
                            
                            print("\n\nBeginning Hand (Cards): \(cards)\n\n")
                            
                            self.giveCards(cards)
                            
                            print(self.hand!.cards.count)
                            
                            guard let delegate = self.timelinePlayerDelegate else {
                                print("Delegate does not exist when hands are given")
                                return
                            }
                            delegate.gameUpdated()
                        }
                        break
                        
                    // MARK: New Card
                    case Utilities.Constants.get("NewCardAction") as! String:
                        
                        let to = msg["to"] as! NSDictionary
                        let toJSON = Utilities.Convert.fromPlayerDictionaryToJSON((to))
                        
                        if self.isMe(toJSON) {
                            
                            let c = req["card"] as! String
                            
                            let cardJSON = JSON.parse(c)
                            
                            let card = TimelineCard(json: cardJSON)
                            
                            self.hand!.addCard(card)
                            
                            print(self.hand!.cards.count)
                            
                            guard let delegate = self.timelinePlayerDelegate else {
                                print("Delegate does not exist when hands are given")
                                return
                            }
                            delegate.gameUpdated()
                        }
                        break
                        
                    // MARK: Change Player Turn
                    case Utilities.Constants.get("ChangePlayerTurn") as! String:
                        let player = req["player"] as! NSDictionary
                        
                        let playeJSON = Utilities.Convert.fromPlayerDictionaryToJSON(player)
                        
                        self.myTurn = self.isMe(playeJSON)
                        
                        print("\((self.myTurn ? "My" : "Other Player's")) turn!")
                        break
                        
                    // MARK: Ask If Won
                    case Utilities.Constants.get("AskIfWonAction") as! String:
                        
                        let didWin = self.didWin()
                        
                        let data = [
                            "type": "MESSAGE",
                            "room": self.room,
                            "from": self.getFromSelf(),
                            "to": Utilities.Constants.get("GameRole") as! String,
                            "response" : [
                                "action" : Utilities.Constants.get("AnswerIfWonAction") as! String,
                                "success": didWin
                            ]
                        ]
                        
                        self.socket.emit("MESSAGE", data)
                        
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
    func gameEnded(win: Bool)
}