//
//  TimelineGameViewController.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class TimelineGameViewController: GameViewController, TimelineGameDalegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Timeline view controller loaded")
    }
    
    func gameUpdated() {
        // Handle Game Updated
    }
}
