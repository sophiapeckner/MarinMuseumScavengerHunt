//
//  ItemDescriptionViewController.swift
//  MarinMuseumScavengerHunt
//
//  Created by Sophia Peckner on 7/10/21.
//

import UIKit

class ItemDescriptionViewController: UIViewController {

    @IBOutlet weak var exhibitImg: UIImageView!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var WhiteBlockImg: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var currentID = exhibitInfo[currentKey]?[1]
        var currentName = exhibitInfo[currentKey]?[2]
        var currentDescription = exhibitInfo[currentKey]?[3]
        
        itemName.text = currentName
        itemDescription.text = currentDescription
        
        foundExhibits[currentKey] = [currentID!, currentName!]
        print(foundExhibits)
        
        // Styles
        WhiteBlockImg.layer.cornerRadius = 25
        NextButton.backgroundColor = UIColor.clear
        NextButton.layer.cornerRadius = 6
        NextButton.layer.borderWidth = 2
        NextButton.layer.borderColor = UIColor(red:17/255, green:138/255, blue:178/255, alpha: 1).cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
            
        var url = URL(string: exhibitInfo[currentKey]![0] as! String)!
        
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    self.exhibitImg.image = UIImage(data: data)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
