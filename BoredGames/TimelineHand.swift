//
//  TimelineHand.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/29/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import Foundation

class TimelineHand: NSObject {
    
    var cards: [TimelineCard]
    
    override init() {
        self.cards = [TimelineCard]()
    }
    
    init(cards: [TimelineCard]) {
        self.cards = cards
    }
    
    init(json: JSON) {
        self.cards = [TimelineCard]()
        for cardJSON in json["cards"].arrayValue {
            let card = TimelineCard(json: cardJSON)
            self.cards.append(card)
        }
    }
    
    func toJSON() -> JSON {
        // Cards
        var cardsJSON = [JSON]()
        for card in cards {
            cardsJSON.append(card.toJSON())
        }
        
        // JSONify
        let json = JSON([
            "cards" : JSON(cardsJSON)
            ])
        return json
    }
    
    func getCard(index: Int) -> TimelineCard {
        return self.cards.removeAtIndex(index)
    }
}