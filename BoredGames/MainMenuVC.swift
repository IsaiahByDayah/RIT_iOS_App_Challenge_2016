//
//  MainMenuVC.swift
//  BoredGames
//
//  Created by Arthur Burgin on 1/29/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {

    var socket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let path = NSBundle.mainBundle().pathForResource("Constants", ofType: "plist") else {
            return
        }
        
        guard let properties = NSDictionary(contentsOfFile: path) else {
            return
        }
        
        let herokuURL = Utilities.Constants.getConstantFromPlist("HerokuURL") as! String
        
        socket = SocketIOClient(socketURL: NSURL(string: herokuURL)!)
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.on("message") {data, ack in
            if let msg = data[0] as? String {
                print(msg)
            }
        }
        
        socket.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scanGameCode(sender: AnyObject) {
        
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