//
//  CardView.swift
//  BoardGames
//
//  Created by Isaiah Smith on 1/31/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var card: TimelineCard?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInitialization()
    }
    
    func commonInitialization() {
        let v = NSBundle.mainBundle().loadNibNamed("CardView", owner: self, options: nil).first as! UIView
        v.frame = self.bounds
        self.addSubview(v)
    }
    
    func setNewCard(newCard: TimelineCard) {
        self.card = newCard
        
        let image = UIImage(named: card!.imageName)!
        self.imageView.image = image
        
        self.yearLabel.text = self.card!.year
        
        self.titleLabel.text = self.card!.title
    }
}
