//
//  MainMenuVC.swift
//  BoredGames
//
//  Created by Arthur Burgin on 1/29/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {

    var socket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // let deck = TimelineDeckAmericanHistory()
        
        
        
//        let card = deck.draw()
//        
//        print("Old Plain Card: \(card)")
//        
//        let cardJSON = card.toJSON()
//        
//        print("Old JSON Card: \(cardJSON)")
//        
//        let cardJSONString = cardJSON.rawString()!
//        
//        print("Old JSON Card String: \(cardJSONString)")
//        
//        let herokuURL = Utilities.Constants.get("HerokuURL") as! String
//        self.socket = SocketIOClient(socketURL: NSURL(string: herokuURL)!)
//        
//        self.socket.on("connect") {data, ack in
//            self.socket.emit("RETURN", [
//                "type": "JOIN_ROOM",
//                "room": [
//                    "role" : Utilities.Constants.get("PlayerRole") as! String,
//                    "playerID" : Utilities.Constants.get("AllPlayerIDs") as! String,
//                    "socketID" : Utilities.Constants.get("AllSocketIDs") as! String
//                ],
//                "to": Utilities.Constants.get("ServerRole") as! String,
//                "thing" : [
//                    "card" : cardJSONString,
//                ]
//            ])
//        }
//        
//        self.socket.on("RETURN") {data, ack in
//            print("Data: \(data)")
//            
//            let dict = data[0] as! NSDictionary
//            
//            print("Data as Dictionary: \(dict)")
//            
//            let ncardJSONString = dict["thing"] as! NSDictionary
//            
//            print("New JSON Card String: \(ncardJSONString)")
////
////            let ncardJSON = JSON.parse(ncardJSONString)
////            
////            print("New JSON Card: \(ncardJSON)")
////            
////            let ncard = TimelineCard.parse(ncardJSON)
////            
////            print("New Plain Card: \(ncard)")
//        }
//        
//        self.socket.connect()
        
        
        
        
        
        
        
        
        /*
        let cards = [deck.draw(), deck.draw()]
        
        print("Old Plain Cards: \(cards)")
        
        let cardsJSON = TimelineCard.jsonify(cards)
        
        print("Old JSON Card: \(cardsJSON)")
        
        let cardsJSONListJSON = JSON(cardsJSON)
        
        print("Old JSON Cards List JSON: \(cardsJSONListJSON)")
        
        let cardsJSONListJSONString = cardsJSONListJSON.rawString()!
        
        print("Old JSON Card List JSON String: \(cardsJSONListJSONString)")
        
        let herokuURL = Utilities.Constants.get("HerokuURL") as! String
        self.socket = SocketIOClient(socketURL: NSURL(string: herokuURL)!)
        
        self.socket.on("connect") {data, ack in
        self.socket.emit("RETURN", [
        "cards" : cardsJSONListJSONString
        ])
        }
        
        self.socket.on("RETURN") {data, ack in
        print("Data: \(data)")
        
        let ncardsJSONListJSONString = data[0]["cards"] as! String
        
        print("New JSON Card List JSON String: \(ncardsJSONListJSONString)")
        
        let ncardsJSONListJSON = JSON.parse(ncardsJSONListJSONString).arrayValue
        
        print("New JSON Card List JSON: \(ncardsJSONListJSON)")
        
        let ncards = TimelineCard.parse(ncardsJSONListJSON)
        
        print("New Plain Card: \(ncards)")
        }
        
        self.socket.connect()
        */
        
        
        
//        let herokuURL = Utilities.Constants.get("HerokuURL") as! String
//        self.socket = SocketIOClient(socketURL: NSURL(string: herokuURL)!)
//        
//        self.socket.on("connect") {data, ack in
//            print("Game socket connected")
//        }
//        
//        self.socket.on("MESSAGE") {data, ack in
//            //print("Data: \(data)")
//            
//            let dict = data[0] as! NSDictionary
//            
//            print("Dict: \(dict)")
//        }
//        
//        self.socket.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prepareToUnwindBackToMainMenuFromScanComplete(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func prepareToUnwindBackToMainMenuFromTLHand(segue: UIStoryboardSegue) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}