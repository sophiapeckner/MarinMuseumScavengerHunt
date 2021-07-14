//
//  PresentItemViewController.swift
//  MarinMuseumScavengerHunt
//
//  Created by Sophia Peckner on 7/10/21.
//

import UIKit

var exhibitInfo =
[0: ["https://s3.us-west-2.amazonaws.com/app-catalogit-media-public/accounts/473/image/1867bfd0-c50d-11e9-9151-a7f96dbf5326-tBBtcUc.sm.jpg",
     "01",
     "1868 velocipede",
    "Pierre Michaux, his son Ernest and business partners, in Paris, were the first commercial makers of pedal bicycles, in the mid to late 1860s. At the time the vehicles were called velocipedes. Competitors began to build velocipedes as well, and this example could be by one of them. Cranks and pedals are on the front wheel, a direct-drive system. One turn of the pedals takes you the circumference of the wheel. This velocipede's 36-inch drive wheel provides a very low gear compared to bicycles of today. Cradles above the front wheel (forward of the head tube) allowed riders to rest their legs when coasting down hills. A handlebar-operated rear brake provided some (marginal) sense of safety. The Calcium King acetylene lantern displayed on the velocipede is from a different period -  the 1890s."],
 1:
    ["https://s3.us-west-2.amazonaws.com/app-catalogit-media-public/accounts/473/image/d73421d0-101f-11ea-8718-25ab7f2f97a4-tCSPvcN.sm.jpeg",
        "02",
        "1885 (circa) Bayliss, Thomas 'Eureka' direct-steering roadster tricycle",
        "This chain-drive tricycle has James Starley's differential gearing, so the drive wheels can turn at appropriate rates while powering through corners. The Eureka has a hand and/or foot-operated band brake. Note the circular brake disc near the down tube. The fork has coil springs at each end of the head tube. A slightly later version served as the model for Carl Benz' 1886 motor car."],
 2:
    ["https://s3.us-west-2.amazonaws.com/app-catalogit-media-public/accounts/473/image/ab364fd0-c511-11e9-9151-a7f96dbf5326-tBBtjrh.sm.jpg",
        "03",
        "1886 Rudge high-wheeler",
        "This 1886 Rudge is a fine example from the height of highwheeler supremecy, built for all-around use. High wheeler's weighed anywhere from a 19-pound Humber track racer to a 60-pound long-distance touring machine, this Rudge weighing 44 pounds.Daniel Rudge, founder of the company, is credited with greatly advancing ball-bearing technology, which allowed bicycle wheels to roll smoothly. Rudge patented his adjustable ball bearings in 1878 and they were sold to his competitors for many years. Rudge bearings and William Bown's 'Aeolus' bearings, made for early bicycles, are the grandparents of the ball bearings used throughout industry today. Boston's Stoddard, Lovering & Co. was the importer for the 'American Rudge.' Gearing: 53 inches (driving wheel diameter)"
        ]
]
var currentKey = -1
var currentExhibit = exhibitInfo[currentKey]
var foundExhibits : [Int:Array] = [Int:Array<String>]()

class PresentItemViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var WhiteBlockImg: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var exhibitImg: UIImageView!
    @IBOutlet weak var inputBoxLabel: UILabel!
    @IBOutlet weak var ContinueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputBoxLabel.text = "Type the two digit code above!"
        ContinueButton.isEnabled = false
        currentKey += 1
        currentExhibit = exhibitInfo[currentKey]
        
        WhiteBlockImg.layer.cornerRadius = 25
        ContinueButton.backgroundColor = UIColor.clear
        ContinueButton.layer.cornerRadius = 6
        ContinueButton.layer.borderWidth = 2
        ContinueButton.layer.borderColor = UIColor(red:17/255, green:138/255, blue:178/255, alpha: 1).cgColor
        
        if (currentKey >= exhibitInfo.count) {
            ContinueButton.isHidden = true
            textField.isHidden = true
            mainTitle.text = "You're Done!"
            inputBoxLabel.text = ""
            exhibitImg.image = UIImage(named:"confetti")
        }
        //        https://www.zerotoappstore.com/how-to-hide-keyboard-in-swift-return-key.html
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                view.addGestureRecognizer(tap) // Add gesture recognizer to background view
        textField.delegate = self
    }
    
    @objc func handleTap() {
        textField.resignFirstResponder() // dismiss keyoard
        var myCode: String = textField.text!
        
        if (myCode != currentExhibit?[1]) {
            inputBoxLabel.text = "Incorrect, try again!"
            inputBoxLabel.textColor = UIColor.red
        } else {
            inputBoxLabel.text = "Correct! Press Continue to read more."
            inputBoxLabel.textColor = UIColor.green
            ContinueButton.isEnabled = true
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if (currentKey < exhibitInfo.count) {
            
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
        
    }
    
    
    @IBAction func continueButtonTap(_ sender: UIButton) {
        var myCode: String = textField.text!
//        checkCode(code: myCode)
        
        if (myCode != currentExhibit?[1]) {
            inputBoxLabel.text = "Incorrect, try again!"
        } else {
//            performSegue(withIdentifier: "ExhibitDescription", sender: sender)
            ContinueButton.isEnabled = true
        }
    }
    
    /*
    func checkCode(code: String) {
        if (code != currentExhibit?[1]) {
            inputBoxLabel.text = "Incorrect, try again!"
        } else {
            performSegue(withIdentifier: "ExhibitDescription", sender: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss Keyboard:
        textField.resignFirstResponder()
        return true
    }
}
