//
//  Player.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import Foundation

class Player: NSObject {

    var id: String
    var socket: SocketIOClient
    var room: String!
    
    override init(){
        self.id = NSUUID().UUIDString
        
        let herokuURL = Utilities.Constants.get("HerokuURL") as! String
        self.socket = SocketIOClient(socketURL: NSURL(string: herokuURL)!)
    }
    
    convenience init(room: String){
        self.init()
        self.room = room
    }
    
    func giveRoom(newRoom: String){
        self.room = newRoom
    }
    
    // Will override
    func setup() {
        // Perform task to setup player
        // - handle socket events
        // - start socket
    }
    
    func getPlayerViewController() -> PlayerViewController {
        let vc = PlayerViewController()
        vc.player = self
        return vc
    }
}