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
    var cardsOnScreen: [UIImageView]? = []
    var test: [String]? = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("Timeline view controller loaded")
        
        self.timelineGame = self.game as! TimelineGame
        self.timelineGame.dealAndStart()
    }
    
    func createCardOnScreen(card: TimelineCard, index: Int) -> UIImageView{
        
        let newCard = UIImageView(frame: CGRectMake(self.view.frame.width/2.5, self.view.frame.height/1.2, 150, 150))
        
        newCard.backgroundColor = UIColor.redColor()
        //newCard.image = card.imageName
        let newCardTitle = card.title
        test?.insert(newCardTitle, atIndex: index)
        
        
        return newCard
        
    }
    
    
    func animateCard(card: UIImageView, x: CGFloat, y: CGFloat, color: UIColor, delay: Double){
        
        self.view.addSubview(card)
        
        Utilities.Flow.run(delay) { () -> () in
            UIView.animateWithDuration(2.0) { () -> Void in
                
                card.backgroundColor = color
                
                card.frame = CGRect(x: x, y: y, width: 150, height: 150)
            }
        }
        
        card.backgroundColor = UIColor.redColor()
        
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
        let newCard = createCardOnScreen(card, index: index)
        cardsOnScreen?.insert(newCard, atIndex: index)
        
        switch(cardsOnScreen!.count){
            case 1:
                animateCard(cardsOnScreen![index], x: view.frame.width/2.63, y: 500, color: UIColor.greenColor(), delay: 0.5)
                break;
            case 2:
                if(index == 0){
                    animateCard(cardsOnScreen![index], x: view.frame.width/3.6, y: 500, color: UIColor.redColor(), delay: 0.5)
                }else{
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.5)
                }
                break;
            case 3:
                if(index == 0){
                    animateCard(cardsOnScreen![index], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                }else if(index == 1){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.63, y: 500, color: UIColor.redColor(), delay: 0.25)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.1)
                }else{
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.25)
                }
                break;
            case 4:
                if(index == 0){
                    animateCard(cardsOnScreen![index], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                }else if(index == 1){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.63, y: 500, color: UIColor.redColor(), delay: 0.25)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                }else if(index == 2){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.25)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                }else if(index == 3){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.69, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                }
                break;
            case 5:
                if(index == 0){
                    animateCard(cardsOnScreen![index], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 1){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.63, y: 500, color: UIColor.redColor(), delay: 0.25)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 2){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.25)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 3){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.69, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }
                else if(index == 4){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.45, y: 500, color: UIColor.blackColor(), delay: 0.25)
                }
                break;
            case 6:
                if(index == 0){
                    animateCard(cardsOnScreen![index], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 1){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 2){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.25)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 3){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.25)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }
                else if(index == 4){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.25)
                }
                else if(index == 5){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }
                break;
            case 7:
                if(index == 0){
                    animateCard(cardsOnScreen![index], x: view.frame.width/4.4, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 1){
                    animateCard(cardsOnScreen![0], x: view.frame.width/4.4, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 2){
                    animateCard(cardsOnScreen![0], x: view.frame.width/4.4, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 3){
                    animateCard(cardsOnScreen![0], x: view.frame.width/4.4, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.25)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 4){
                    animateCard(cardsOnScreen![0], x: view.frame.width/4.4, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.25)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 5){
                    animateCard(cardsOnScreen![0], x: view.frame.width/4.4, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 6){
                    animateCard(cardsOnScreen![0], x: view.frame.width/4.4, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.25)
                }
                break;
            case 8:
                if(index == 0){
                    animateCard(cardsOnScreen![index], x: view.frame.width/4.9, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/4.4, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![2], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![7], x: view.frame.width/1.15, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    
                }
                break;
            default:
                break;
        }
        
//        if(cardsOnScreen?.count == 1){
//            animateCard(cardsOnScreen![index], x: view.frame.width/2.63, y: 500, color: UIColor.greenColor(), delay: 0.5)
//        }else if(cardsOnScreen?.count == 2){
//            if(index == 0){
//                animateCard(cardsOnScreen![index], x: view.frame.width/3.6, y: 500, color: UIColor.redColor(), delay: 0.5)
//            }else{
//                animateCard(cardsOnScreen![index], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.5)
//            }
//        }else{
//            if(index == 0){
//                print(test)
//                for(var x = 1; x < cardsOnScreen!.count; x++){
//                    let mult = CGFloat(cardsOnScreen!.count) - 0.2
//                    animateCard(cardsOnScreen![x], x: view.frame.width/mult, y: 500, color: UIColor.purpleColor(), delay: 0.5)
//                }
//                var num = 3.2 * CGFloat(cardsOnScreen!.count/4)
//                animateCard(cardsOnScreen![index], x: view.frame.width/num, y: 500, color: UIColor.redColor(), delay: 0.5)
//            }
//        }
        
    }
    
    func boardUpdated() {
        // Handle Game Updated
        // - Clear Screen
        // - Recreate screen
    }
}
