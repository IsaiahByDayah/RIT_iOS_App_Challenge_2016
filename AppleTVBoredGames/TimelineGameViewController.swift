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
    
    var cardsOnScreen: [UIImageView]? = []
    
    private let unwindBackToShowcaseSegueIdentifier = "unwindFromTLGVCBackToGameShowcase"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timelineGame = self.game as! TimelineGame
        self.timelineGame.dealAndStart()
    }
    
    func createCardOnScreen(card: TimelineCard, index: Int) -> UIImageView{
        
        let newCard = UIImageView(frame: CGRectMake(self.view.frame.width/2.5, self.view.frame.height/1.2, 150, 150))
        
        newCard.backgroundColor = UIColor.redColor()
        //newCard.image = card.imageName
        
        return newCard
        
    }
    
    
    func animateCard(card: UIImageView, x: CGFloat, y: CGFloat, color: UIColor, delay: Double){
        
        self.view.addSubview(card)
        
        Utilities.Flow.run(delay) { () -> () in
            UIView.animateWithDuration(2.0) { () -> Void in
                
                card.backgroundColor = color
                
                card.frame = CGRect(x: x, y: y, width: 300, height: 300)
            }
        }
        
        card.backgroundColor = UIColor.redColor()
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
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 1){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 2){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.05, y: 500, color: UIColor.redColor(), delay: 0.25)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.redColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 3){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.25)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }
                else if(index == 4){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.25)
                }
                else if(index == 5){
                    animateCard(cardsOnScreen![0], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }
                break;
            case 7:
                if(index == 0){
                    animateCard(cardsOnScreen![index], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 1){
                    animateCard(cardsOnScreen![0], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 2){
                    animateCard(cardsOnScreen![0], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 3){
                    animateCard(cardsOnScreen![0], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.25)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 4){
                    animateCard(cardsOnScreen![0], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.25)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 5){
                    animateCard(cardsOnScreen![0], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                }else if(index == 6){
                    animateCard(cardsOnScreen![0], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.25)
                }
                break;
            case 8:
                if(index == 0){
                    animateCard(cardsOnScreen![index], x: view.frame.width/12.0, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![2], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![7], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    
                }else if(index == 1){
                    animateCard(cardsOnScreen![0], x: view.frame.width/12.0, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![2], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![7], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    
                }else if(index == 2){
                    animateCard(cardsOnScreen![0], x: view.frame.width/12.0, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![7], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    
                }else if(index == 3){
                    animateCard(cardsOnScreen![0], x: view.frame.width/12.0, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![4], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![7], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    
                }else if(index == 4){
                    animateCard(cardsOnScreen![0], x: view.frame.width/12.0, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.25)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![7], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    
                }else if(index == 5){
                    animateCard(cardsOnScreen![0], x: view.frame.width/12.0, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.25)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![7], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    
                }else if(index == 6){
                    animateCard(cardsOnScreen![0], x: view.frame.width/12.0, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.25)
                    animateCard(cardsOnScreen![7], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    
                }else if(index == 7){
                    animateCard(cardsOnScreen![0], x: view.frame.width/12.0, y: 500, color: UIColor.blackColor(), delay: 0.1)
                    animateCard(cardsOnScreen![1], x: view.frame.width/5.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![2], x: view.frame.width/3.6, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![3], x: view.frame.width/2.63, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![4], x: view.frame.width/2.05, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![5], x: view.frame.width/1.69, y: 500, color: UIColor.greenColor(), delay: 0.1)
                    animateCard(cardsOnScreen![6], x: view.frame.width/1.45, y: 500, color: UIColor.purpleColor(), delay: 0.1)
                    animateCard(cardsOnScreen![index], x: view.frame.width/1.27, y: 500, color: UIColor.blackColor(), delay: 0.25)
                    
                }
                break;
            default:
                break;
        }
        
    }
    
    func boardUpdated() {
        // Handle Game Updated
        // - Clear Screen
        // - Recreate screen
    }
    
    func gameEnded(winner: JSON) {
        let confirmation = UIAlertController(title: "Good Game!", message: "Thanks for playing!", preferredStyle: UIAlertControllerStyle.Alert)
        
        confirmation.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            // Handle user confirming word reset
            self.unwindBackToGameShowcase()
        }))
        
        self.presentViewController(confirmation, animated: true, completion: nil)
    }
    
    func unwindBackToGameShowcase() {
        self.performSegueWithIdentifier(self.unwindBackToShowcaseSegueIdentifier, sender: self)
    }
}
