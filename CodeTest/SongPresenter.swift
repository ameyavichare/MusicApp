//
//  SongPresenter.swift
//  CodeTest
//
//  Created by Ameya Vichare on 21/08/17.
//  Copyright © 2017 vit. All rights reserved.
//

import Foundation
import UIKit

struct SongData {
    
    let name: String
    let image: UIImage
    let link: String
    let price: String
}

protocol songView: NSObjectProtocol {
    
    func setSongs(_ songs: [SongData])
}

class SongPresenter {
    
    fileprivate let songService:SongsService
    weak fileprivate var songView : songView?
    
    init(songService: SongsService) {
        
        self.songService = songService
    }
    
    func attachView(view: songView) {
        
        songView = view
    }
    
    func getSongs() {
        
        songService.getSongs { [weak self] songs in
            
            let mappedSongs = songs.map {
                
                return SongData(name: "\($0.name)", image: $0.image, link: "\($0.link)", price: "\($0.price)")
            }
            self?.songView?.setSongs(mappedSongs)
        }
    }
}
