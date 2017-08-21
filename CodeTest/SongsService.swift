//
//  SongsService.swift
//  CodeTest
//
//  Created by Ameya Vichare on 21/08/17.
//  Copyright © 2017 vit. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class SongsService {
    
    func getServer(url: String, completion: @escaping (JSON) -> ()) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                switch response.result {
                case.success( _):
                    let json = JSON(response.result.value)
                    completion(json)
                case.failure( _):
                    completion(JSON(data: Data()))
                }
        }
    }
    
    func getSongs(_ callback:@escaping ([Song]) -> Void) {
        
        var songs = [Song]()
        getServer(url: "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=50/json") { (response) in
            let json = response
            for item in json["feed"]["entry"].arrayValue {

                ImageLoader.sharedLoader.imageForUrl(urlString: item["im:image"][2]["label"].stringValue, completionHandler: {  (image: UIImage?, url: String) in
                    
                    songs.append(Song(name: item["im:name"]["label"].stringValue, image: image!, price: item["im:price"]["label"].stringValue, link: item["im:collection"]["link"]["attributes"]["href"].stringValue))
                })
            }
        }
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callback(songs)
        }
    }
}
