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
    
    var board = [TimelineCard]()
    
    init(deck: TimelineDeck) {
        self.deck = deck
        
        super.init(title: Utilities.Constants.get("TimelineTitle") as! String, minPlayers: Utilities.Constants.get("TimelineMinPlayers") as! Int, maxPlayers: Utilities.Constants.get("TimelineMinPlayers") as! Int)
    }
    
    convenience init() {
        self.init(deck: TimelineDeckAmericanHistory())
    }
    
    func tellNextPlayerToGo() {
        let player = self.players[self.getNextPlayerIndex()]
        
        let data = [
            "type": "MESSAGE",
            "room": self.id,
            "from": self.getFromSelf(),
            "to": self.getToAllPlayers(),
            "request" : [
                "action" : Utilities.Constants.get("ChangePlayerTurn") as! String,
                "player" : self.getTo(player)
            ]
        ]
        
        self.socket.emit("MESSAGE", data)
    }
    
    func dealCards() {
        self.deck.shuffle()
        
        for player in self.players {
            
            var cards = [TimelineCard]()
            
            for _ in 0..<4 {
                let card = self.deck.draw()
                cards.append(card)
            }
            
            let cardsJSON = TimelineCard.jsonify(cards)
            
            let listJSON = JSON(cardsJSON)
            
            guard let json = listJSON.rawString() else {
                print("Could not stringify cards.")
                return
            }
            
            let data = [
                "type": "MESSAGE",
                "room": self.id,
                "from": self.getFromSelf(),
                "to": self.getTo(player),
                "request" : [
                    "action" : Utilities.Constants.get("BeginingHandAction") as! String,
                    "hand" : json
                ]
            ]
            
            self.socket.emit("MESSAGE", data)
        }
    }
    
    func dealAndStart() {
        self.announceNewBoard()
        self.dealCards()
        self.tellNextPlayerToGo()
    }
    
    func sendResults(success: Bool, msg: JSON){
        guard let cardString = msg["response"]["card"].rawString() else {
            print("Couldn't get string of card to send results to spectators")
            return
        }
        
        let data = [
            "type": "MESSAGE",
            "room": self.id,
            "from": self.getFromSelf(),
            "to": self.getToSpectators(),
            "request" : [
                "action" : Utilities.Constants.get("MoveAction") as! String,
                "player" : self.getTo(msg["from"]),
                "success" : success,
                "move" : [
                    "card": cardString,
                    "index": msg["response"]["index"].intValue
                ]
            ]
        ]
        
        self.socket.emit("MESSAGE", data)
    }
    
    func isCardRight(card: TimelineCard, index: Int) -> Bool {
        
        var cardLeftBool = false
        var cardRightBool = false
        
        if index == 0 || (board[index-1].year <= card.year) {
            cardLeftBool = true
        }
        
        if index == board.count || (board[index+1].year >= card.year) {
            cardRightBool = true
        }
        
        return cardLeftBool && cardRightBool
    }
    
    func announceNewBoard() {
        let cardsJSON = TimelineCard.jsonify(self.board)
        
        let listJSON = JSON(cardsJSON)
        
        guard let json = listJSON.rawString() else {
            print("Could not stringify cards.")
            return
        }
        
        let data = [
            "type": "MESSAGE",
            "room": self.id,
            "from": self.getFromSelf(),
            "to": self.getToAllPlayers(),
            "request" : [
                "action" : Utilities.Constants.get("BoardUpdatedAction") as! String,
                "board" : json
            ]
        ]
        
        self.socket.emit("MESSAGE", data)
    }
    
    func askPlayerIfWon(player: JSON) {
        let data = [
            "type": "MESSAGE",
            "room": self.id,
            "from": self.getFromSelf(),
            "to": self.getTo(player),
            "request" : [
                "action" : Utilities.Constants.get("AskIfWonAction") as! String
            ]
        ]
        
        self.socket.emit("MESSAGE", data)
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
                    
                    switch msg["response"]["action"].stringValue {
                    
                    // MARK: New Card Played
                    case Utilities.Constants.get("PlayCardAction") as! String:
                        let c = msg["response"]["card"]
                        
                        let card = TimelineCard(json: c)
                        
                        let i = msg["response"]["index"].intValue
                        
                        // TODO: Handle the playing of card
                        print("Card Played: \(card)")
                        
                        
                        // Announce Result
                        let success = self.isCardRight(card, index: i)
                        
                        self.sendResults(success, msg: msg)
                        
                        if success {
                            self.board.insert(card, atIndex: i)
                            
                            self.announceNewBoard()
                            
                            self.askPlayerIfWon(<#T##player: JSON##JSON#>)
                        } else {
                            let card = self.deck.draw()
                            
                            guard let cardString = card.toJSON().rawString() else {
                                print("Couldn't get string of card to send results to spectators")
                                return
                            }
                            
                            let data = [
                                "type": "MESSAGE",
                                "room": self.id,
                                "from": self.getFromSelf(),
                                "to": self.getTo(msg["from"]),
                                "request" : [
                                    "action" : Utilities.Constants.get("NewCardAction") as! String,
                                    "card" : cardString
                                ]
                            ]
                            
                            self.socket.emit("MESSAGE", data)
                            
                            self.tellNextPlayerToGo()
                        }
                        /*
                            - Is Card correct?
                                - if not
                                    - Announce Move
                                        - Send new card to player
                                        - tell next player to go
                                - if is
                                    - Anounce Move
                                        - Announce new board
                                        - Ask player if they won
                                            - if did
                                                - Announce winner
                                            - if not
                                                - Tell next player to go
                        */
                        break
                        
                    default:
                        print("Unknown Action Recieved. Ignoring...")
                    }
                    
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