//
//  SongPresenter.swift
//  CodeTest
//
//  Created by Ameya Vichare on 21/08/17.
//  Copyright © 2017 vit. All rights reserved.
//

import Foundation
import UIKit

//Data model to be used for the view

struct SongData {
    
    let name: String
    let image: UIImage
    let link: String
    let price: String
}

//abstraction of the view to be used in the presenter, without presenter knowing about UIViewController

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
        
        //calling songService method getSongs and calling setSongs which will in return load the tableView in UIViewController code
        
        songService.getSongs { [weak self] songs in
            
            let mappedSongs = songs.map {
                
                return SongData(name: "\($0.name)", image: $0.image, link: "\($0.link)", price: "\($0.price)")
            }
            self?.songView?.setSongs(mappedSongs)
        }
    }
}
