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
    var players: [Player]
    var maxPlayers: Int
    var minPlayers: Int
    var socket: SocketIOClient
    
    init(title: String, minPlayers: Int, maxPlayers: Int){
        self.id = NSUUID().UUIDString
        self.title = title
        self.players = [Player]()
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
    func getGameViewController() -> GameViewController {
        let vc = GameViewController()
        return vc
    }
    
    func isRequiredPlayersMet() -> Bool {
        return players.count >= minPlayers
    }
}