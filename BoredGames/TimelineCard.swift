//
//  TimelineCard.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/29/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import Foundation

class TimelineCard: NSObject {
    var id: String
    var year: String
    var title: String
    var imageName: String
    
    override var description: String {
        get {
            return self.toJSON().rawString()!
        }
    }
    
    init(id: String, year: String, title: String, imageName: String) {
        self.id = id
        self.year = year
        self.title = title
        self.imageName = imageName
    }
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.year = json["year"].stringValue
        self.title = json["title"].stringValue
        self.imageName = json["imageName"].stringValue
    }
    
    func toJSON() -> JSON {
        let json = JSON([
            "id"        : self.id,
            "year"      : self.year,
            "title"     : self.title,
            "imageName" : self.imageName
        ])
        
        return json
    }
    
    static func jsonify(card: TimelineCard) -> JSON {
        let json = JSON([
            "id"        : card.id,
            "year"      : card.year,
            "title"     : card.title,
            "imageName" : card.imageName
            ])
        
        return json
    }
    
    static func jsonify(cards: [TimelineCard]) -> [JSON] {
        var cardsJSON = [JSON]()
        
        for card in cards {
            let cardJSON = TimelineCard.jsonify(card)
            cardsJSON.append(cardJSON)
        }
        
        return cardsJSON
    }
    
    static func parse(json: JSON) -> TimelineCard {
        let id = json["id"].stringValue
        let year = json["year"].stringValue
        let title = json["title"].stringValue
        let imageName = json["imageName"].stringValue
        
        let card = TimelineCard(id: id, year: year, title: title, imageName: imageName)
        
        return card
    }
    
    static func parse(json: [JSON]) -> [TimelineCard] {
        var cards = [TimelineCard]()
        
        for cardJSON in json {
            let card = TimelineCard.parse(cardJSON)
            cards.append(card)
        }
        
        return cards
    }
}