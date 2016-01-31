//
//  TimelineGameViewController.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class TimelineGameViewController: GameViewController, TimelineGameDalegate {
    
    var timelineGame: TimelineGame!
    
    var deck: UIView?
    var cardsOnScreen: [UIView]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("Timeline view controller loaded")
        
        self.timelineGame = self.game as! TimelineGame
        self.timelineGame.dealAndStart()
    }
    
    
    func animateCard(title: String, x: CGFloat, y: CGFloat, color: UIColor, delay: Double){
        
        let title = UIImageView(frame: CGRectMake(self.view.frame.width/2.5, self.view.frame.height/1.2, 150, 150))
        
        self.view.addSubview(title)
        
        Utilities.Flow.run(delay) { () -> () in
            UIView.animateWithDuration(2.0) { () -> Void in
                
                title.backgroundColor = color
                
                title.frame = CGRect(x: x, y: y, width: 150, height: 150)
            }
        }
        
        title.backgroundColor = UIColor.redColor()
        
        /*
        if self.deck != nil {
        self.deck!.removeFromSuperview()
        self.deck = nil
        }
        
        if self.cardsOnScreen != nil {
        for card in self.cardsOnScreen! {
        card.removeFromSuperview()
        }
        self.cardsOnScreen = nil
        }
        
        self.deck = UIImageView(frame: CGRectMake(self.view.frame.width/2.5, self.view.frame.height/1.2, 150, 150))
        deck!.backgroundColor = UIColor.redColor()
        self.view.addSubview(deck!)
        
        let cardSize = CGSize(width: 200, height: 300)
        
        for card in self.timelineGame.board {
        
        }
        
        animateCard("card1", x: view.frame.width/3.6, y: 500, color: UIColor.grayColor(), delay: 1.0)
        animateCard("card2", x: view.frame.width/2.63, y: 500, color: UIColor.greenColor(), delay: 1.3)
        animateCard("card3", x: view.frame.width/2.05, y: 500, color: UIColor.yellowColor(), delay: 1.6)
        animateCard("card4", x: view.frame.width/1.69, y: 500, color: UIColor.purpleColor(), delay: 1.9)
        animateCard("card5", x: view.frame.width/1.45, y: 500, color: UIColor.blackColor(), delay: 2.1)
        */
    }
    
    
    func cardPlayed(card: TimelineCard, atIndex index: Int) {
        // Add new card to Screen
    }
    
    func gameUpdated() {
        // Handle Game Updated
        // - Clear Screen
        // - Recreate screen
    }
}
