//
//  ViewController.swift
//  MarinMuseumScavengerHunt
//
//  Created by Sophia Peckner on 7/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var StartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartButton.backgroundColor = UIColor.clear
        StartButton.layer.cornerRadius = 6
        StartButton.layer.borderWidth = 2
        StartButton.layer.borderColor = UIColor(red:17/255, green:138/255, blue:178/255, alpha: 1).cgColor
        
    }
}

