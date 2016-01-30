//
//  PlayerScanViewController.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class PlayerScanViewController: UIViewController {

    @IBOutlet weak var qrImageView: UIImageView!
    
    @IBOutlet weak var playersJoinedTextLabel: UILabel!
    
    @IBOutlet weak var minPlayersTextLabel: UILabel!
    
    @IBOutlet weak var maxPlayersTextLabel: UILabel!
    
    @IBOutlet weak var doneScanningButton: UIButton!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let codeObj = JSON([
            "id":game.id,
            "title": game.title
            ])
        
        let code = "\(codeObj)"
        
        guard let qr = Utilities.QR.getQRCodeForValue(code, ofSize: qrImageView.frame.size) else {
            return
        }
        
        qrImageView.image = qr
        
        minPlayersTextLabel.text = "Min: \(game.minPlayers) Players"
        
        maxPlayersTextLabel.text = "Max: \(game.maxPlayers) Players"
    }
    
    override func viewDidAppear(animated: Bool) {
        if game == nil {
            alertIssue()
        }
    }
    
    func alertIssue(){
        let confirmation = UIAlertController(title: "Uh Oh!", message: "We weren't able to get the game your trying to play", preferredStyle: UIAlertControllerStyle.Alert)
        
        confirmation.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            // Handle user confirming word reset
            self.cancelButtonPressed(self)
        }))
        
        self.presentViewController(confirmation, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        if game.isRequiredPlayersMet() {
            
            let vc = game.getGameViewController()
            
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    override func canPerformUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject) -> Bool {
        if self.respondsToSelector(action) {
            return true
        }
        return false
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
