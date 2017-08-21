//
//  ImageLoader.swift
//  CodeTest
//
//  Created by Ameya Vichare on 21/08/17.
//  Copyright © 2017 vit. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    
    var cache = NSCache<NSString, NSData>()
    
    class var sharedLoader : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        
        DispatchQueue.main.async {
            let data: Data? = self.cache.object(forKey: urlString as NSString) as Data?
            
            if let goodData = data {
                let image = UIImage(data: goodData)
                DispatchQueue.main.async {
                    
                    completionHandler(image, urlString)
                }
                return
            }
            let songUrl = urlString
            
            if !songUrl.isEmpty {
                
                let url = URL(string: songUrl)
                let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    
                    if error != nil
                    {
                        completionHandler(#imageLiteral(resourceName: "default"), urlString)
                        return
                    }
                    else
                    {
                        DispatchQueue.main.async(execute: {
                            if let image = UIImage(data: data!) {
                                let dat = NSData(data: data!)
                                self.cache.setObject(dat, forKey: urlString as NSString)
                                completionHandler(image, urlString)
                                return
                            }
                        })
                    }
                })
                task.resume()
            }
            else {
                completionHandler(#imageLiteral(resourceName: "default"), urlString)
                return
            }
        }
    }
}
