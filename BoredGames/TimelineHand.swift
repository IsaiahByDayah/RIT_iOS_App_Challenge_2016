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
    
    var selectedCardIndex: Int = -1
    
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
    
    func giveCards(newCards: [TimelineCard]){
        self.selectedCardIndex = -1
        
        self.cards = newCards
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
    
    func getCard(index: Int) -> TimelineCard? {
        if index >= 0 && index < self.cards.count {
            return self.cards.removeAtIndex(index)
        }
            
        return nil
    }
    
    func getSelectedCard() -> TimelineCard? {
        return getCard(self.selectedCardIndex)
    }
    
    func selectCardAtIndex(index: Int) -> Bool {
        if index >= 0 && index < self.cards.count {
            selectedCardIndex = index
            return true
        }
        
        return false
    }
}