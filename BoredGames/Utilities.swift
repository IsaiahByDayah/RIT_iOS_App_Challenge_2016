//
//  Utilities.swift
//  BoredGames
//
//  Created by Isaiah Smith on 1/29/16.
//  Copyright © 2016 Isaiah Smith. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    class Number: NSObject {
        static func random(min: Int, excludingMax max: Int) -> Int {
            return Int(arc4random_uniform(UInt32(max - min))) + min
        }
    }
    
    class Image: NSObject {
        static func convertImage(image: UIImage?, toSize size: CGSize) -> UIImage? {
            
            guard let theImage = image else {
                return nil
            }
            
            guard let coreImage = theImage.CIImage else {
                return nil
            }
            
            let scaleX = size.width / coreImage.extent.size.width
            let scaleY = size.height / coreImage.extent.size.height
            
            let transformedImage = coreImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
            
            let scaledImage = UIImage(CIImage: transformedImage)
            
            return scaledImage
        }
    }
    
    class QR: NSObject {
        static func getQRCodeForValue(val: String, ofSize size: CGSize) -> UIImage? {
            
            guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
                return nil
            }
            
            let valData = val.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            
            filter.setValue(valData, forKey: "inputMessage")
            filter.setValue("Q", forKey: "inputCorrectionLevel")
            
            guard let qrcodeImage = filter.outputImage else {
                return nil
            }
            
            let image = UIImage(CIImage: qrcodeImage)
            
            let scaledImage = Utilities.Image.convertImage(image, toSize: size)
            
            return scaledImage
        }
    }
    
    class Constants: NSObject{
        static func get(varName: String) -> AnyObject?{
            
//            if varName == "HerokuURL" {
//                return "http://localhost:18000" as AnyObject?
//            }
            
            guard let path = NSBundle.mainBundle().pathForResource("Constants", ofType: "plist") else{
                return nil
            }
            
            guard let constantVariable = NSDictionary(contentsOfFile: path) else{
                return nil
            }
            
            let constantValue = constantVariable[varName]
            
            return constantValue
            
        }
        
    }
}











