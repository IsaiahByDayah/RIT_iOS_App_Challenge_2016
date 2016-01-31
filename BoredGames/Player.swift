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
    var socketID: String!
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
    
    // Will override
    func setup() {
        // Perform task to setup player
        // - handle socket events
        // - start socket
    }
    
    // Will override
    func tearDown(){
        // Perform task to teardown player
        // - stop socket
    }
    
    func getFromSelf() -> NSDictionary {
        return [
            "role": Utilities.Constants.get("PlayerRole") as! String,
            "playerID" : self.id,
            "socketID": self.socketID
        ]
    }
    
    func isMe(player: JSON) -> Bool {
        if player["playerID"].stringValue == self.id {
            return true
        }
        
        return false
    }
    
    func giveRoom(newRoom: String){
        self.room = newRoom
    }
    
    func getPlayerViewController() -> PlayerViewController {
        let vc = PlayerViewController()
        vc.player = self
        return vc
    }
}