//
//  mainViewController.swift
//  CodeTest
//
//  Created by Ameya Vichare on 21/08/17.
//  Copyright © 2017 vit. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {
    
    @IBOutlet weak var songsTable: UITableView!
    fileprivate let songPresenter = SongPresenter(songService: SongsService())
    fileprivate var songsToDisplay = [SongData]()
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songPresenter.attachView(view: self)
        songPresenter.getSongs()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func passDetail(index: Int) {
        selectedIndex = index
        self.performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let vc = segue.destination as? detailViewController {
                let songData = songsToDisplay[selectedIndex]
                vc.songImage = songData.image
                vc.songTitle = songData.name
                vc.songLink = songData.link
                vc.songPrice = songData.price
            }
        }
    }
}

extension mainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let songData = songsToDisplay[indexPath.row]
        cell.textLabel?.text = songData.name
        cell.imageView?.image = songData.image
        cell.selectionStyle = .none
        return cell
    }
}

extension mainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passDetail(index: indexPath.row)
    }
}

extension mainViewController: songView {
    func setSongs(_ songs: [SongData]) {
        songsToDisplay = songs
        DispatchQueue.main.async {
            self.songsTable.reloadData()
        }
    }
}
