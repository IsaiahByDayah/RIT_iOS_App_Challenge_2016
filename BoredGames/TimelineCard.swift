//
//  TimelineCard.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/29/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import Foundation

class TimelineCard: NSObject {
    var id: Int
    var year: Int
    var title: String
    var imageName: String
    
    override var description: String {
        get {
            return self.toJSON().rawString()!
        }
    }
    
    init(id: Int, year: Int, title: String, imageName: String) {
        self.id = id
        self.year = year
        self.title = title
        self.imageName = imageName
    }
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.year = json["year"].intValue
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
}