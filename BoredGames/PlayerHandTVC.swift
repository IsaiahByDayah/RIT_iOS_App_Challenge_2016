//
//  PlayerHandTVC.swift
//  BoredGames
//
//  Created by Arthur Burgin on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class PlayerHandTVC: PlayerViewController, UITableViewDataSource, UITableViewDelegate, TimelinePlayerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var timelinePlayer: TimelinePlayer!
    
    private let showBoardSegueIdentifier = "timelinePlayerPresentBoardSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timelinePlayer = player as! TimelinePlayer
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        guard let hand = timelinePlayer.hand else {
            return 0
        }
        return hand.cards.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CardCell", forIndexPath: indexPath)
        
        guard let hand = timelinePlayer.hand else {
            return cell
        }
        
        let card = hand.cards[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = card.title

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if timelinePlayer.canTakeTurn() {
            guard let hand = timelinePlayer.hand else {
                return
            }
            
            let selected = hand.selectCardAtIndex(indexPath.row)
            
            if !selected {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }
    
    func gameUpdated() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == showBoardSegueIdentifier {
            return timelinePlayer.canTakeTurn()
        }
        return false
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == showBoardSegueIdentifier {
            let vc = segue.destinationViewController as! GameBoardTVC
            
            vc.timelinePlayer = self.timelinePlayer
        }
    }

}
