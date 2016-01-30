//
//  TimelineDeck.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/29/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import Foundation

class TimelineDeck: NSObject {
    
    var cards: [TimelineCard]
    
    private var usedCards: [TimelineCard]
    
    override var description: String {
        get {
            return self.toJSON().rawString()!
        }
    }
    
    override init() {
        self.cards = [TimelineCard]()
        self.usedCards = [TimelineCard]()
    }
    
    init(json: JSON) {
        
        // Cards
        self.cards = [TimelineCard]()
        for cardJSON in json["cards"].arrayValue {
            let card = TimelineCard(json: cardJSON)
            self.cards.append(card)
        }
        
        // Used Cards
        self.usedCards = [TimelineCard]()
        for cardJSON in json["usedCards"].arrayValue {
            let card = TimelineCard(json: cardJSON)
            self.usedCards.append(card)
        }
    }
    
    func toJSON() -> JSON {
        
        // Cards
        var cardsJSON = [JSON]()
        for card in cards {
            cardsJSON.append(card.toJSON())
        }
        
        // Used Cards
        var usedCardsJSON = [JSON]()
        for card in usedCards {
            usedCardsJSON.append(card.toJSON())
        }
        
        // JSONify
        let json = JSON([
            "cards" : JSON(cardsJSON),
            "usedCards" : JSON(usedCardsJSON)
        ])
        return json
    }
    
    func shuffle() {
        var newCards = [TimelineCard]()
        
        var allCards = self.cards + self.usedCards
        let num = allCards.count
        for _ in 0..<num {
            let index = Utilities.Number.random(0, excludingMax: self.cards.count)
            let card = allCards.removeAtIndex(index)
            newCards.append(card)
        }
        
        self.cards = newCards
        self.usedCards = []
    }
    
    func draw() -> TimelineCard {
        let r = Utilities.Number.random(0, excludingMax: self.cards.count)
        let card = self.cards.removeAtIndex(r)
        
        self.usedCards.append(card)
        
        return card
    }
}