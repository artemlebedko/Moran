//
//  ViewController.swift
//  Moran
//
//  Created by artemlebedko on 02/23/2019.
//  Copyright (c) 2019 artemlebedko. All rights reserved.
//

import UIKit
import Moran

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    var transition: Moran?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateButton()
    }
    
    @IBAction func didButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            detailViewController.modalPresentationStyle = .custom
            detailViewController.transitioningDelegate = self.transition
            present(detailViewController, animated: true)
        }

    }

    func configurateButton() {
        button.layer.cornerRadius = 20.0
        self.transition = Moran(animatedView: button, transitionDuration: 0.5)
    }
}

