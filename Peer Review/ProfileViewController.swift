//
//  ViewController.swift
//  Peer Review
//
//  Created by Austin on 5/20/18.
//  Copyright © 2018 Austin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screenSize: CGRect = UIScreen.main.bounds
        
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
//        myView.backgroundColor = UIColor.lightGray
        
        
        let myImageView = UIImageView(frame: CGRect(x: 15, y: screenSize.height * 0.1, width: screenSize.width * 0.25 - 15, height: screenSize.height * 0.1))
        myImageView.image = UIImage(named: "noicon.png")
        myView.addSubview(myImageView)

        
        let myLabel = UILabel(frame: CGRect(x: screenSize.width * 0.25, y: screenSize.height * 0.1, width: screenSize.width * 0.75, height: screenSize.height * 0.1))
        myLabel.text = "Austin Vershel"
        myLabel.lineBreakMode = .byWordWrapping
        myLabel.numberOfLines = 0
        myLabel.textAlignment = .center
        myLabel.font = myLabel.font.withSize(30)
        //        myLabel.adjustsFontSizeToFitWidth = true
        //        myLabel.minimumScaleFactor = 0.2
        myView.addSubview(myLabel)
        
        let myTextView = UILabel(frame: CGRect(x: 15, y: myLabel.frame.maxY + screenSize.height * 0.025, width: screenSize.width  - 30, height: screenSize.height * 0.2))
        myTextView.text = "Austin Vershel is a graduate from James Madison University with a degree in Computer Science. He has a strong passion for creating software including web and mobile applications."
        myTextView.lineBreakMode = .byWordWrapping
        myTextView.numberOfLines = 0
        myView.addSubview(myTextView)
        
        
        let myFirstBox = UIView(frame: CGRect(x: 15, y: myTextView.frame.maxY + screenSize.height * 0.05, width: screenSize.width * 0.5 - 30, height: screenSize.height * 0.35))
        myFirstBox.layer.borderWidth = 2
        myFirstBox.layer.borderColor = UIColor.black.cgColor
        myFirstBox.layer.shadowColor = UIColor.black.cgColor
        myFirstBox.layer.shadowOpacity = 1
        myFirstBox.layer.shadowOffset = CGSize.zero
        myFirstBox.layer.shadowRadius = 10
        
        let starBox = UIView(frame: CGRect(x: myFirstBox.frame.minX + 5, y: myFirstBox.frame.minY + 5, width: myFirstBox.frame.width - 10, height: myFirstBox.frame.height * 0.25))
        starBox.layer.borderWidth = 0.5
        starBox.layer.borderColor = UIColor.black.cgColor
        myView.addSubview(starBox)
        
        
        
        let myStarImage = UIImageView(frame: CGRect(x: myFirstBox.frame.minX + 5, y: myFirstBox.frame.minY + 5, width: myFirstBox.frame.width - 10, height: myFirstBox.frame.height * 0.25))
        myStarImage.image = UIImage(named: "3-5stars.png")
        myView.addSubview(myStarImage)
        
        
        let starLabel = UILabel(frame: CGRect(x: myFirstBox.frame.minX + 5, y: starBox.frame.maxY + (myFirstBox.frame.height * 0.025), width: myFirstBox.frame.width - 10, height: myFirstBox.frame.height * 0.3))
        starLabel.text = "3.5"
        starLabel.font = starLabel.font.withSize(25)
        starLabel.textAlignment = .center
        myView.addSubview(starLabel)
        
        let avgScoreLabel = UILabel(frame: CGRect(x: myFirstBox.frame.minX + 5, y: starLabel.frame.maxY + (myFirstBox.frame.height * 0.025), width: myFirstBox.frame.width - 10, height: myFirstBox.frame.height * 0.2))
        avgScoreLabel.text = "Reviews of Me"
        avgScoreLabel.textAlignment = .center
        avgScoreLabel.lineBreakMode = .byWordWrapping
        myView.addSubview(avgScoreLabel)
        
        let myFirstButton = UIButton(frame: CGRect(x: myFirstBox.frame.maxX - 30, y: myFirstBox.frame.maxY - 30, width: 25, height: 25))
        myFirstButton.setTitle(">", for: .normal)
        myFirstButton.setTitleColor(UIColor.blue, for: .normal)
        myFirstButton.addTarget( self, action: #selector(toMyReviews), for: .touchUpInside)

        myView.addSubview(myFirstButton)


        
        
        myView.addSubview(myFirstBox)
        
        let mySecondBox = UIView(frame: CGRect(x: screenSize.width * 0.5 + 15, y: myTextView.frame.maxY + screenSize.height * 0.05, width: screenSize.width * 0.5 - 30, height: screenSize.height * 0.35))
        mySecondBox.layer.borderWidth = 2
        mySecondBox.layer.borderColor = UIColor.black.cgColor
        mySecondBox.layer.shadowColor = UIColor.black.cgColor
        mySecondBox.layer.shadowOpacity = 1
        mySecondBox.layer.shadowOffset = CGSize.zero
        mySecondBox.layer.shadowRadius = 10
        myView.addSubview(mySecondBox)
        
        let secondStarBox = UIView(frame: CGRect(x: mySecondBox.frame.minX + 5, y: mySecondBox.frame.minY + 5, width: mySecondBox.frame.width - 10, height: mySecondBox.frame.height * 0.25))
        secondStarBox.layer.borderWidth = 0.5
        secondStarBox.layer.borderColor = UIColor.black.cgColor
        myView.addSubview(secondStarBox)
        
        
        
        let secondStarImage = UIImageView(frame: CGRect(x: mySecondBox.frame.minX + 5, y: mySecondBox.frame.minY + 5, width: mySecondBox.frame.width - 10, height: mySecondBox.frame.height * 0.25))
        secondStarImage.image = UIImage(named: "3-5stars.png")
        myView.addSubview(secondStarImage)
        
        
        let secondStarLabel = UILabel(frame: CGRect(x: mySecondBox.frame.minX + 5, y: secondStarBox.frame.maxY + (mySecondBox.frame.height * 0.025), width: mySecondBox.frame.width - 10, height: mySecondBox.frame.height * 0.3))
        secondStarLabel.text = "3.5"
        secondStarLabel.font = starLabel.font.withSize(25)
        secondStarLabel.textAlignment = .center
        myView.addSubview(secondStarLabel)
        
        let secondAvgScoreLabel = UILabel(frame: CGRect(x: mySecondBox.frame.minX + 5, y: secondStarLabel.frame.maxY + (mySecondBox.frame.height * 0.025), width: mySecondBox.frame.width - 10, height: mySecondBox.frame.height * 0.2))
        secondAvgScoreLabel.text = "Reviews by Me"
        secondAvgScoreLabel.textAlignment = .center
        secondAvgScoreLabel.lineBreakMode = .byWordWrapping
        myView.addSubview(secondAvgScoreLabel)
        
        let mySecondButton = UIButton(frame: CGRect(x: mySecondBox.frame.maxX - 30, y: mySecondBox.frame.maxY - 30, width: 25, height: 25))
        mySecondButton.setTitle(">", for: .normal)
        mySecondButton.setTitleColor(UIColor.blue, for: .normal)
        mySecondButton.addTarget(self, action: #selector(toMyReviews), for: .touchUpInside)

        myView.addSubview(mySecondButton)

        
        
        self.view.addSubview(myView)
        
        
    }
    @objc func toMyReviews(_ sender: UIButton){
        performSegue(withIdentifier: "profileToMyReviews", sender: nil)
    }
    
    @objc func toReviewsOfMe(_ sender: UIButton){
        performSegue(withIdentifier: "profileToReviewsOfMe", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    
}
