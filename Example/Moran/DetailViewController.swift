//
//  DetailViewController.swift
//  Moran_Example
//
//  Created by Artem on 23/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateButton()
    }
    
    @IBAction func didCloseButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func configurateButton() {
        closeButton.layer.cornerRadius = 20.0
    }
}
