//
//  PlayerCardPositionChoice.swift
//  BoredGames
//
//  Created by Arthur Burgin on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class PlayerCardPositionChoice: UIViewController {
    
    var timelinePlayer: TimelinePlayer!
    
    var boardSelectIndex: Int!
    
    @IBAction func insertBeforeCard(sender: AnyObject) {
        
        chooseCard(-1)
    }

    @IBAction func insertAfterCard(sender: AnyObject) {
        
        chooseCard(1)
    }
    
    func chooseCard(shift: Int){
        
        self.timelinePlayer.sendChoice(boardSelectIndex+shift)
        
        popBack()
    }
    
    func popBack() {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
