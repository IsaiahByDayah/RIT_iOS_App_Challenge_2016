//
//  PlayerCardPositionChoice.swift
//  BoredGames
//
//  Created by Arthur Burgin on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class PlayerCardPositionChoice: UIViewController {
    @IBAction func insertBeforeCard(sender: AnyObject) {
        
        let index = boardArr.indexOf(chosenBoardCard!)
        
        boardArr.insert((chosenPlayerCard?.title)!, atIndex: index! - 1)
        
        print(boardArr)
        
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("loadBefore", object: nil)
        
        navigationController?.popToRootViewControllerAnimated(true)
        
    }

    @IBAction func insertAfterCard(sender: AnyObject) {
        
        let index = boardArr.indexOf(chosenBoardCard!)
        
        boardArr.insert((chosenPlayerCard?.title)!, atIndex: index! + 1)
        
        print(boardArr)
        
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("loadAfter", object: nil)
        
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
