//
//  Game.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class Game: NSObject {
    var id: String
    var title: String
    var players: [JSON]
    var maxPlayers: Int
    var minPlayers: Int
    var socket: SocketIOClient
    var socketID: String!
    
    var scanDelagate: GameScanDelagate?
    
    init(title: String, minPlayers: Int, maxPlayers: Int){
        self.id = NSUUID().UUIDString
        self.title = title
        self.players = [JSON]()
        self.maxPlayers = maxPlayers
        self.minPlayers = minPlayers

        let herokuURL = Utilities.Constants.get("HerokuURL") as! String
        self.socket = SocketIOClient(socketURL: NSURL(string: herokuURL)!)
    }
    
    // Will override
    func setup(){
        // Perform task to setup game
        // - handle socket events
        // - start socket
    }
    
    // Will override
    func tearDown(){
        print("WARN: This is the default \(__FUNCTION__) function.")
        
        // Perform task to teardown game
        // - stop socket
    }
    
    // Will override
    func getGameViewController() -> GameViewController {
        print("WARN: This is the default \(__FUNCTION__) function.")
        
        let vc = GameViewController()
        return vc
    }
    
    // Will override
    func startGame() {
        print("WARN: This is the default \(__FUNCTION__) function.")
        
        // Make call to start the game
    }
    
    func getFromSelf() -> NSDictionary {
        return [
            "role": Utilities.Constants.get("GameRole") as! String,
            "gameID" : self.id,
            "socketID": self.socketID
        ]
    }
    
    func getToAllPlayers() -> NSDictionary {
        return [
            "role" : Utilities.Constants.get("PlayerRole") as! String,
            "playerID" : Utilities.Constants.get("AllPlayerIDs") as! String,
            "socketID" : Utilities.Constants.get("AllSocketIDs") as! String
        ]
    }
    
    func hasPlayerJoinedAlready(player: JSON) -> Bool {
        var joined = false
        
        for p in self.players {
            if p["playerID"].stringValue == player["playerID"].stringValue {
                joined = true
            }
        }
        
        return joined
    }
    
    func addPlayer(player: JSON){
        if !self.hasPlayerJoinedAlready(player) {
            self.players.append(player)
        }
    }
    
    func isRequiredPlayersMet() -> Bool {
        return self.players.count >= self.minPlayers
    }
}

protocol GameScanDelagate {
    func playersUpdated()
}