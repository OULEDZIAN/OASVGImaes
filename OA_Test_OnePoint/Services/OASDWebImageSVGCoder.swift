//
//  OASDWebImageSVGCoder.swift
//  OA_Test_OnePoint
//
//  Created by Ahmed OULEDZIAN on 07/07/2018.
//  Copyright © 2018 Ahmed OULEDZIAN. All rights reserved.
//

import UIKit
import SDWebImage
import SVGKit

class OASDWebImageSVGCoder: NSObject, SDWebImageCoder {
    func canDecode(from data: Data?) -> Bool {
        guard let _ = SVGKImage(data: data) else {
            return false
        }
        return true
    }
    
    func decodedImage(with data: Data?) -> UIImage? {
        do {
            let anSVGImage: SVGKImage = SVGKImage(data: data)
            return anSVGImage.uiImage
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    func decompressedImage(with image: UIImage?, data: AutoreleasingUnsafeMutablePointer<NSData?>, options optionsDict: [String : NSObject]? = nil) -> UIImage? {
        return image
    }
    
    func canEncode(to format: SDImageFormat) -> Bool {
        return false
    }
    
    func encodedData(with image: UIImage?, format: SDImageFormat) -> Data? {
        return nil
    }

}
