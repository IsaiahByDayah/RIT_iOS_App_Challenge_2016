//
//  ViewController.swift
//  AppleTVBoredGames
//
//  Created by Isaiah Smith on 1/29/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class GameShowcaseController: UIViewController {

    var socket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func gamePressed(sender: AnyObject) {
    
        let game = TimelineGame(deck: TimelineDeckAmericanHistory())
        
        let scanVC = storyboard?.instantiateViewControllerWithIdentifier("PlayerScanViewController") as! PlayerScanViewController
        scanVC.game = game
        game.scanDelagate = scanVC
        
        self.presentViewController(scanVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func canPerformUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject) -> Bool {
        if self.respondsToSelector(action) {
            return true
        }
        return false
    }

    @IBAction func prepareForUnwindBackToShowcase(segue: UIStoryboardSegue) {
        
    }
}

