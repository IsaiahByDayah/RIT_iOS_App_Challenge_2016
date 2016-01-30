//
//  PlayerScanViewController.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/30/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class PlayerScanViewController: UIViewController {

    @IBOutlet weak var QRImageView: UIImageView!
    
    @IBOutlet weak var playersJoinedLabel: UILabel!
    
    @IBOutlet weak var minPlayersLabel: UILabel!
    
    @IBOutlet weak var maxPlayersLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let code = JSON([
            "id":game.id,
            "title": game.title
        ]).rawString()!
        
        guard let qr = Utilities.QR.getQRCodeForValue(code, ofSize: QRImageView.frame.size) else {
            return
        }
        
        QRImageView.image = qr
        
        minPlayersLabel.text = "Min: \(game.minPlayers) Players"
        
        maxPlayersLabel.text = "Max: \(game.maxPlayers) Players"
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
            vc.game = self.game
            
            self.presentViewController(vc, animated: true, completion: nil)
        }
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
