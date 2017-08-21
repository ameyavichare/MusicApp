//
//  detailViewController.swift
//  CodeTest
//
//  Created by Ameya Vichare on 21/08/17.
//  Copyright © 2017 vit. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var link: UIButton!
    
    var songImage = UIImage()
    var songTitle = String()
    var songLink = String()
    var songPrice = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        image.image = songImage
        name.text = songTitle
        price.text = songPrice
        price.layer.cornerRadius = 3
        price.clipsToBounds = true
        price.layer.borderColor = UIColor.blue.cgColor
        price.layer.borderWidth = 1
        price.textColor = UIColor.blue
    }

    @IBAction func buyPressed(_ sender: Any) {
        let url = URL(string: songLink)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
