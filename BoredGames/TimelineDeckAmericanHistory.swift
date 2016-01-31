//
//  AmericanHistoryTimelineDeck.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/29/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import Foundation

class TimelineDeckAmericanHistory: TimelineDeck {
    
    override init(){
        super.init()
        
        let decksDict = Utilities.Constants.get("TimelineDecks") as! NSDictionary
        
        let ahDeckDict = decksDict["AmericanHistory"] as! [NSDictionary]
        
        for cardDict in ahDeckDict {
            let id = cardDict["id"] as! String
            let year = cardDict["year"] as! String
            let title = cardDict["title"] as! String
            let imageName = cardDict["imageName"] as! String
            
            let card = TimelineCard(id: id, year: year, title: title, imageName: imageName)
            
            self.cards.append(card)
        }
    }
}