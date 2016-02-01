//
//  AudioManager.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/31/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager: NSObject {
    
    var musicPlayer: AVAudioPlayer?
    
    init(fileName: String, fileType: String, shouldRepeat: Bool){
    
        let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)!)
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: sound)
        } catch _ {
            print("Could not load file")
            return
        }
        
        musicPlayer?.prepareToPlay()
        
        if shouldRepeat {
            musicPlayer?.numberOfLoops = -1
        }
    }
    
    func setVolume(vol: Float){
        self.musicPlayer?.volume = vol
    }
    
    func play(){
        musicPlayer?.play()
    }
    
    func pause(){
        musicPlayer?.pause()
    }
    
    func stop(){
        musicPlayer?.stop()
    }
}