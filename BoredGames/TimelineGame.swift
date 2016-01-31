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
    
    var shuffleSound: AudioManager?
    
    private let vcIdentifier = "TimelineGameViewController"
    
    var board = [TimelineCard]()
    
    init(deck: TimelineDeck) {
        self.deck = deck
        
        super.init(title: Utilities.Constants.get("TimelineTitle") as! String, minPlayers: Utilities.Constants.get("TimelineMinPlayers") as! Int, maxPlayers: Utilities.Constants.get("TimelineMaxPlayers") as! Int)
    }
    
    convenience init() {
        self.init(deck: TimelineDeckAmericanHistory())
    }
    
    func tellNextPlayerToGo() {
        print("Players: \(self.players)")
        
        let index = self.getNextPlayerIndex()
        
        print("Index of player to go: \(index)")
        
        print("Index of next player to go: \(self.getCurrentPlayerIndex())")
        
        let player = self.players[index]
        
        print("Player to go: \(player)")
        
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
        
        self.shuffleSound = AudioManager(fileName: Utilities.Constants.get("TimelineShuffleSoundFileName") as! String, fileType: Utilities.Constants.get("TimelineShuffleSoundFileType") as! String, shouldRepeat: false)
        self.shuffleSound?.setVolume(0.25)
        
        self.shuffleSound?.play()
        
        let startingCard = deck.draw()
        
        self.board.append(startingCard)
        
        self.delagate?.cardPlayed(startingCard, atIndex: 0)
        
        for player in self.players {
            
            var cards = [TimelineCard]()
            
            let num = Utilities.Constants.get("TimelineNumberOfCardsInStartingHand") as! Int
            
            for _ in 0..<num {
                let card = self.deck.draw()
                cards.append(card)
            }
            
            let cardsJSON = TimelineCard.jsonify(cards)
            
            let listJSON = JSON(cardsJSON)
            
            guard let json = listJSON.rawString() else {
                print("Could not stringify cards.")
                return
            }
            
            // json = json.stringByReplacingOccurrencesOfString("\n", withString: "")
            //json = json.stringByReplacingOccurrencesOfString(" ", withString: "")
            
//            let json: NSData
//            do {
//                json = try listJSON.rawData()
//            } catch _ {
//                json = NSData()
//            }
            
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
        self.dealCards()
        self.announceNewBoard()
        self.tellNextPlayerToGo()
    }
    
    func sendResults(success: Bool, msg: NSDictionary){
        let res = msg["response"] as! NSDictionary
        
        let cardString = res["card"] as! String
        
        //cardString = cardString.stringByReplacingOccurrencesOfString("\n", withString: "")
        //cardString = cardString.stringByReplacingOccurrencesOfString(" ", withString: "")

//        let cardString: NSData
//        do {
//            cardString = try msg["response"]["card"].rawData()
//        } catch _ {
//            cardString = NSData()
//        }
        
        let person = msg["from"] as! NSDictionary
        let personJSON = Utilities.Convert.fromPlayerDictionaryToJSON(person)
        
        let data = [
            "type": "MESSAGE",
            "room": self.id,
            "from": self.getFromSelf(),
            "to": self.getToSpectators(),
            "request" : [
                "action" : Utilities.Constants.get("MoveAction") as! String,
                "player" : self.getTo(personJSON),
                "success" : success,
                "move" : [
                    "card": cardString,
                    "index": res["index"] as! Int
                ]
            ]
        ]
        
        self.socket.emit("MESSAGE", data)
    }
    
    func isCardRight(card: TimelineCard, index: Int) -> Bool {
        
        var tempBoard = [Int]()
        
        for i in 0..<board.count {
            tempBoard.append(Int(board[i].year)!)
        }
        
        tempBoard.insert(Int(card.year)!, atIndex: index)
        
        var returnVal = true
        
        var previousYear = tempBoard[0]
        
        for i in 0..<tempBoard.count {
            let year = tempBoard[i]
            
            if year >= previousYear {
                previousYear = year
            } else {
                returnVal = false
            }
        }
        
        return returnVal
    }
    
    func announceNewBoard() {
        let cardsJSON = TimelineCard.jsonify(self.board)
        
        let listJSON = JSON(cardsJSON)
        
        guard let json = listJSON.rawString() else {
            print("Could not stringify cards.")
            return
        }
        
        //json = json.stringByReplacingOccurrencesOfString("\n", withString: "")
        //json = json.stringByReplacingOccurrencesOfString(" ", withString: "")

//        let json: NSData
//        do {
//            json = try listJSON.rawData()
//        } catch _ {
//            json = NSData()
//        }
        
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
        
        self.delagate?.boardUpdated()
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
    
    func announceWinner(player: JSON){
        let data = [
            "type": "MESSAGE",
            "room": self.id,
            "from": self.getFromSelf(),
            "to": self.getToAllPlayers(),
            "request" : [
                "action" : Utilities.Constants.get("EndGameAction") as! String,
                "winner" : self.getTo(player)
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
            // print("Data: \(data)")
            
            let msg = data[0] as! NSDictionary
            
            // print("Message: \(msg)")
            
            // Parse message from player perspective
            
            switch msg["type"] as! String{
                
            // MARK: Initial Connect Info
            case "CONNECT_INFO":
                
                self.socketID = msg["socketID"] as! String
                
                let data = [
                    "type": "JOIN_ROOM",
                    "room": self.id,
                    "from": self.getFromSelf(),
                    "to": Utilities.Constants.get("ServerRole") as! String
                ]
                    
                self.socket.emit("JOIN_ROOM", data)
                break
                
            // MARK: Someone Disconnected Info
            case "DISCONNECT_INFO":
                
                let playerSocketID = msg["socketID"] as! String
                
                var json = JSON.parse("{}")
                json["socketID"].string = playerSocketID
                
                print("SocketID disconnected: \(playerSocketID)")
                
                print("My players: \(self.players)")
                
                let indexOfPlayer = self.getIndexOfPlayerWithSocketID(playerSocketID)
                
                if indexOfPlayer >= 0 {
                    print("My player Disconnected...");
                    
                    self.players.removeAtIndex(indexOfPlayer)
                    
                    self.scanDelagate?.playersUpdated()
                }
                break
                
            // MARK: Someone Joined The Room
            case "JOIN_ROOM":
                let from = msg["from"] as! NSDictionary
                
                if from["role"] as! String == Utilities.Constants.get("PlayerRole") as! String {
                    let player = Utilities.Convert.fromPlayerDictionaryToJSON(from)
                    print("Players Before: \(self.players)")
                    self.addPlayer(player)
                    print("Current Players: \(self.players)")
                    if let delegate = self.scanDelagate {
                        delegate.playersUpdated()
                    }
                }
                break
                
            // MARK: Message Recieved
            case "MESSAGE":
                let from = msg["from"] as! NSDictionary
                
                switch from["role"] as! String {
                    
                // MARK: From Server
                case Utilities.Constants.get("ServerRole") as! String:
                    print("Got a message from the server")
                    // Handle message from server
                    
                    break
                    
                // MARK: From Player
                case Utilities.Constants.get("PlayerRole") as! String:
                    print("Got a message from a player")
                    // Handle message from player
                    let res = msg["response"] as! NSDictionary
                    
                    let from = msg["from"] as! NSDictionary
                    let fromJSON = Utilities.Convert.fromPlayerDictionaryToJSON(from)
                    
                    switch res["action"] as! String {
                    
                    // MARK: New Card Played
                    case Utilities.Constants.get("PlayCardAction") as! String:
                        let c = res["card"] as! String
                        
                        let cardJSON = JSON.parse(c)
                        
                        let card = TimelineCard(json: cardJSON)
                        
                        let i = res["index"] as! Int
                        
                        // TODO: Handle the playing of card
                        print("Card Played: \(card) \n at index: \(i)")
                        
                        
                        // Announce Result
                        let success = self.isCardRight(card, index: i)
                        
                        print("That move is \(success)!")
                        
                        self.sendResults(success, msg: msg)
                        
                        if success {
                            self.board.insert(card, atIndex: i)
                            
                            self.delagate?.cardPlayed(card, atIndex: i)
                            
                            self.announceNewBoard()
                            
                            self.askPlayerIfWon(fromJSON)
                        } else {
                            let card = self.deck.draw()
                            
                            guard let cardString = card.toJSON().rawString() else {
                                print("Couldn't get string of card to send results to spectators")
                                return
                            }
                            
                            //cardString = cardString.stringByReplacingOccurrencesOfString("\n", withString: "")
                            //cardString = cardString.stringByReplacingOccurrencesOfString(" ", withString: "")
                            
//                            let cardString: NSData
//                            do {
//                                cardString = try card.toJSON().rawData()
//                            } catch _ {
//                                cardString = NSData()
//                            }
                            
                            let data = [
                                "type": "MESSAGE",
                                "room": self.id,
                                "from": self.getFromSelf(),
                                "to": self.getTo(fromJSON),
                                "request" : [
                                    "action" : Utilities.Constants.get("NewCardAction") as! String,
                                    "card" : cardString
                                ]
                            ]
                            
                            self.socket.emit("MESSAGE", data)
                            
                            //self.tellNextPlayerToGo()
                        }
                        
                        self.tellNextPlayerToGo()
                        
                        break
                        
                    // MARK: Answer if won
                    case Utilities.Constants.get("AnswerIfWonAction") as! String:
                        
                        let success = res["success"] as! Bool
                        
                        if success {
                            self.announceWinner(fromJSON)
                            // Go back to main menu
                            self.delagate?.gameEnded(fromJSON)
                            
                        } else {
                            //self.tellNextPlayerToGo()
                        }

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
    func boardUpdated()
    
    func cardPlayed(card: TimelineCard, atIndex index: Int)
    
    func gameEnded(winner: JSON)
}