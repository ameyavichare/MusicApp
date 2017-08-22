//
//  mainViewController.swift
//  CodeTest
//
//  Created by Ameya Vichare on 21/08/17.
//  Copyright © 2017 vit. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {
    
    //table to display songs data
    @IBOutlet weak var songsTable: UITableView!
    fileprivate let songPresenter = SongPresenter(songService: SongsService())
    //array to hold songData
    fileprivate var songsToDisplay = [SongData]()
    //index which stores the row which was selected in table
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //passing the view to the presenter
        songPresenter.attachView(view: self)
        //calling get songs method in presenter
        songPresenter.getSongs()
        //hiding the default navigation bar
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func passDetail(index: Int) {
        //called when row is selected
        selectedIndex = index
        //segue to detailVC
        self.performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let vc = segue.destination as? detailViewController {
                let songData = songsToDisplay[selectedIndex]
                //passing all data to next VC
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
        //displaying relevant data
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
        //executes when setSongs in Presenter is called
        songsToDisplay = songs
        DispatchQueue.main.async {
            self.songsTable.reloadData()
        }
    }
}
