//
//  Game.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import Foundation

class Game: NSObject {
    var id: String
    var title: String
    var players: [Player]
    var maxPlayers: Int
    var socket: SocketIOClient
    
    init(title: String, maxPlayers: Int){
        self.id = NSUUID().UUIDString
        self.title = title
        self.players = [Player]()
        self.maxPlayers = maxPlayers
        
        self.socket = SocketIOClient(socketURL: NSURL(string: "http:www.google.com")!)
        
        guard let path = NSBundle.mainBundle().pathForResource("Constants", ofType: "plist") else {
            return
        }
        
        guard let properties = NSDictionary(contentsOfFile: path) else {
            return
        }
        
        let herokuURL = properties["HerokuURL"]! as! String
        
        self.socket = SocketIOClient(socketURL: NSURL(string: herokuURL)!)
    }
}