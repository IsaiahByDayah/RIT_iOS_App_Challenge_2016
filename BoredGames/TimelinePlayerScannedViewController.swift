//
//  TimelinePlayerNavController.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class TimelinePlayerScannedViewController: PlayerViewController, TimelinePlayerScanCompleteDelegate {
    
    private let continueSegue = "showTimelinePlayerNavVC"
    private let cancelSegue = "cancelBackToMainMenuFromScanComplete"
    
    override func viewDidLoad() {
        let tlPlayer = self.player as! TimelinePlayer
        
        tlPlayer.timelinePlayerScanCompleteDelegate = self
    }
    
    func gameStarted() {
        self.performSegueWithIdentifier(continueSegue, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == cancelSegue {
            self.player.tearDown()
        } else if (segue.identifier == continueSegue) {
            let vc = segue.destinationViewController as! UINavigationController
            
            let tlvc = vc.viewControllers.first as! PlayerHandTVC
            tlvc.player = self.player
            (tlvc.player as! TimelinePlayer).timelinePlayerDelegate = tlvc
            
        }
    }
}
