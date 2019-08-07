//
//  ImageParser.swift
//  JSONTableView
//
//  Created by Brendan Milton on 03/08/2019.
//  Copyright © 2019 Brendan Milton. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

// Cache images generic type to work with multiple values
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadCachedImageURLString(_ urlString: String){
        
        self.image = nil
        
        // Check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            self.image = cachedImage
            return
        }
        
        // Otherwise download the image
        Alamofire.request(urlString).responseImage { response in
            
            if let downloadedImage = response.result.value {
                // image
                imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                self.image = downloadedImage
            }
        }
    }
}
