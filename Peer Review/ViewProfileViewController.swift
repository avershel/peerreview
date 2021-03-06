//
//  ViewController.swift
//  Peer Review
//
//  Created by Austin on 5/20/18.
//  Copyright © 2018 Austin. All rights reserved.
//

import UIKit

class ViewProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screenSize: CGRect = UIScreen.main.bounds
        
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        //        myView.backgroundColor = UIColor.lightGray
        let image = UIImage(named: "settings-512.png") as UIImage?
        
        let settingsbutton = UIButton(frame: CGRect(x:  screenSize.width - 50, y: screenSize.height * 0.05, width: 50, height: 25))
        settingsbutton.setTitle("Back", for: .normal)
        settingsbutton.setTitleColor(UIColor.blue, for: .normal)
        settingsbutton.addTarget( self, action: #selector(toEditProfile), for: .touchUpInside)
        
        myView.addSubview(settingsbutton)
        
        let myImageView = UIImageView(frame: CGRect(x: 15, y: screenSize.height * 0.1, width: screenSize.width * 0.25 - 15, height: screenSize.height * 0.1))
        myImageView.image = UIImage(named: "noicon.png")
        myView.addSubview(myImageView)
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "MyKey2")
        var name = ""
        var about = ""
        let myURLString = "http://prettygoodsports.com/write/api.php?phone=\(token! ?? "0")"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            print("HTML : \(myHTMLString)")
            if myHTMLString.range(of:"Phone") != nil {
                
                var fullNameArr = myHTMLString.components(separatedBy:"}")
                var fullNameArr2 = fullNameArr[0].components(separatedBy:"{")
                let newString = fullNameArr2[1].replacingOccurrences(of: "\",\"", with: "###", options: .literal, range: nil)
                
                //"ID":"3###Phone":"2404058682###Name":"Ave###About":"235"
                var fullNameArr3 = newString.components(separatedBy:"###")
                
                name = fullNameArr3[2].components(separatedBy:"\":\"")[1]
                about = fullNameArr3[3].components(separatedBy:"\":\"")[1]
                about = about.substring(to: about.index(before: about.endIndex))
                
                
            }else{
                name = token!
            }
        } catch let error {
            print("Error: \(error)")
        }
        
        
        
        
        let myLabel = UILabel(frame: CGRect(x: screenSize.width * 0.25, y: screenSize.height * 0.1, width: screenSize.width * 0.75, height: screenSize.height * 0.1))
        myLabel.text = name
        myLabel.lineBreakMode = .byWordWrapping
        myLabel.numberOfLines = 0
        myLabel.textAlignment = .center
        myLabel.font = myLabel.font.withSize(30)
        //        myLabel.adjustsFontSizeToFitWidth = true
        //        myLabel.minimumScaleFactor = 0.2
        myView.addSubview(myLabel)
        
        let myTextView = UILabel(frame: CGRect(x: 15, y: myLabel.frame.maxY + screenSize.height * 0.025, width: screenSize.width  - 30, height: screenSize.height * 0.2))
        myTextView.text = about
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
        var star1holder = Double(round(100*getAvgReviewOfMeScore())/100)
        if(star1holder < 0.5){
            myStarImage.image = UIImage(named: "0-5stars.png")
            
        }else if (star1holder >= 0.5 && star1holder < 1.0){
            myStarImage.image = UIImage(named: "05-5stars.png")
            
        }else if (star1holder >= 1.0 && star1holder < 1.5){
            myStarImage.image = UIImage(named: "1-5stars.png")
            
        }else if (star1holder >= 1.5 && star1holder < 2.0){
            myStarImage.image = UIImage(named: "2-5stars.png")
            
        }else if (star1holder >= 2.0 && star1holder < 2.5){
            myStarImage.image = UIImage(named: "2-5stars.png")
            
        }else if (star1holder >= 2.5 && star1holder < 3.0){
            myStarImage.image = UIImage(named: "25-5stars.png")
            
        }else if (star1holder >= 3.0 && star1holder < 3.5){
            myStarImage.image = UIImage(named: "3o5stars.png")
            
        }else if (star1holder >= 3.5 && star1holder < 4.0){
            myStarImage.image = UIImage(named: "3-5stars.png")
            
        }else if (star1holder >= 4.0 && star1holder < 4.5){
            myStarImage.image = UIImage(named: "4-5stars.png")
            
        }else if (star1holder >= 4.5 && star1holder < 5.0){
            myStarImage.image = UIImage(named: "45-5stars.png")
            
        }else{
            myStarImage.image = UIImage(named: "5-5stars.png")
            
        }
        myView.addSubview(myStarImage)
        
        
        let starLabel = UILabel(frame: CGRect(x: myFirstBox.frame.minX + 5, y: starBox.frame.maxY + (myFirstBox.frame.height * 0.025), width: myFirstBox.frame.width - 10, height: myFirstBox.frame.height * 0.3))
        starLabel.text = "\(Double(round(100*getAvgReviewOfMeScore())/100))"
        starLabel.font = starLabel.font.withSize(25)
        starLabel.textAlignment = .center
        myView.addSubview(starLabel)
        
        let avgScoreLabel = UILabel(frame: CGRect(x: myFirstBox.frame.minX + 5, y: starLabel.frame.maxY + (myFirstBox.frame.height * 0.025), width: myFirstBox.frame.width - 10, height: myFirstBox.frame.height * 0.2))
        avgScoreLabel.text = "Reviews of \(name)"
        avgScoreLabel.textAlignment = .center
        avgScoreLabel.lineBreakMode = .byWordWrapping
        myView.addSubview(avgScoreLabel)
        
        let myFirstButton = UIButton(frame: CGRect(x: myFirstBox.frame.maxX - 30, y: myFirstBox.frame.maxY - 30, width: 25, height: 25))
        myFirstButton.setTitle(">", for: .normal)
        myFirstButton.setTitleColor(UIColor.blue, for: .normal)
        myFirstButton.addTarget( self, action: #selector(toReviewsOfMe), for: .touchUpInside)
        
        //myView.addSubview(myFirstButton)
        
        
        
        
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
        star1holder = Double(round(100*getAvgMyReviewScore())/100)
        if(star1holder < 0.5){
            secondStarImage.image = UIImage(named: "0-5stars.png")
            
        }else if (star1holder >= 0.5 && star1holder < 1.0){
            secondStarImage.image = UIImage(named: "05-5stars.png")
            
        }else if (star1holder >= 1.0 && star1holder < 1.5){
            secondStarImage.image = UIImage(named: "1-5stars.png")
            
        }else if (star1holder >= 1.5 && star1holder < 2.0){
            secondStarImage.image = UIImage(named: "2-5stars.png")
            
        }else if (star1holder >= 2.0 && star1holder < 2.5){
            secondStarImage.image = UIImage(named: "2-5stars.png")
            
        }else if (star1holder >= 2.5 && star1holder < 3.0){
            secondStarImage.image = UIImage(named: "25-5stars.png")
            
        }else if (star1holder >= 3.0 && star1holder < 3.5){
            secondStarImage.image = UIImage(named: "3o5stars.png")
            
        }else if (star1holder >= 3.5 && star1holder < 4.0){
            secondStarImage.image = UIImage(named: "3-5stars.png")
            
        }else if (star1holder >= 4.0 && star1holder < 4.5){
            secondStarImage.image = UIImage(named: "4-5stars.png")
            
        }else if (star1holder >= 4.5 && star1holder < 5.0){
            secondStarImage.image = UIImage(named: "45-5stars.png")
            
        }else{
            secondStarImage.image = UIImage(named: "5-5stars.png")
            
        }
        myView.addSubview(secondStarImage)
        
        
        let secondStarLabel = UILabel(frame: CGRect(x: mySecondBox.frame.minX + 5, y: secondStarBox.frame.maxY + (mySecondBox.frame.height * 0.025), width: mySecondBox.frame.width - 10, height: mySecondBox.frame.height * 0.3))
        secondStarLabel.text = "\(Double(round(100*getAvgMyReviewScore())/100))"
        secondStarLabel.font = starLabel.font.withSize(25)
        secondStarLabel.textAlignment = .center
        myView.addSubview(secondStarLabel)
        
        let secondAvgScoreLabel = UILabel(frame: CGRect(x: mySecondBox.frame.minX + 5, y: secondStarLabel.frame.maxY + (mySecondBox.frame.height * 0.025), width: mySecondBox.frame.width - 10, height: mySecondBox.frame.height * 0.2))
        secondAvgScoreLabel.text = "Reviews by \(name)"
        secondAvgScoreLabel.textAlignment = .center
        secondAvgScoreLabel.lineBreakMode = .byWordWrapping
        myView.addSubview(secondAvgScoreLabel)
        
        let mySecondButton = UIButton(frame: CGRect(x: mySecondBox.frame.maxX - 30, y: mySecondBox.frame.maxY - 30, width: 25, height: 25))
        mySecondButton.setTitle(">", for: .normal)
        mySecondButton.setTitleColor(UIColor.blue, for: .normal)
        mySecondButton.addTarget(self, action: #selector(toMyReviews), for: .touchUpInside)
        
       // myView.addSubview(mySecondButton)
        
        
        
        self.view.addSubview(myView)
       // self.view.addSubview(myFirstButton)
        
        
    }
    @objc func toMyReviews(_ sender: UIButton){
        performSegue(withIdentifier: "profileToMyReviews", sender: nil)
    }
    
    @objc func toReviewsOfMe(_ sender: UIButton){
        performSegue(withIdentifier: "profileToReviewsOfMe", sender: nil)
    }
    @objc func toEditProfile(_ sender: UIButton){
        performSegue(withIdentifier: "viewProfileToMyReviews", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    func getAvgMyReviewScore() -> Double {
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "MyKey2")
        var counter = 0
        var accumulater = 0.0
        let myURLString = "http://prettygoodsports.com/write/PeerReviewByPhone.php?phone=\(token! ?? "0")"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return 0
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            print("HTML : \(myHTMLString)")
            
            var fullNameArr = myHTMLString.components(separatedBy:"###")
            
            for i in 0..<fullNameArr.count - 1 {
                print(i)
                var review = Review()
                
                var id = ""
                var reviewerPhone = ""
                var revieweePhone = ""
                var revieweeName = ""
                var comments = ""
                var stars = ""
                var holder  = fullNameArr[i].replacingOccurrences(of: "{\"", with: "", options: .literal, range: nil)
                holder  = holder.replacingOccurrences(of: "\"}", with: "", options: .literal, range: nil)
                holder = holder.replacingOccurrences(of: "\",\"", with: "###", options: .literal, range: nil)
                var fullNameArr3 = holder.components(separatedBy:"###")
                print(fullNameArr3[0].components(separatedBy:"\":\"").count)
                //   review.id = fullNameArr3[0].components(separatedBy:"\":\"")[1]
                review.reviewerPhone = fullNameArr3[1].components(separatedBy:"\":\"")[1]
                review.revieweePhone = fullNameArr3[2].components(separatedBy:"\":\"")[1]
                review.revieweeName = fullNameArr3[3].components(separatedBy:"\":\"")[1]
                review.comments = fullNameArr3[4].components(separatedBy:"\":\"")[1]
                review.stars = fullNameArr3[5].components(separatedBy:"\":\"")[1]
                review.date = fullNameArr3[6].components(separatedBy:"\":\"")[1]

                counter = counter + 1
                accumulater = accumulater + Double(review.stars)!
                
            }
            
            
            
            
            
            
        } catch let error {
            print("Error: \(error)")
        }
        if(counter == 0){
            return 0
        }
        return (accumulater / Double(counter))
        
    }
    
    func getAvgReviewOfMeScore() -> Double {
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "MyKey2")
        var counter = 0
        var accumulater = 0.0
        let myURLString = "http://prettygoodsports.com/write/PeerReviewOfPhone.php?phone=\(token! ?? "0")"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return 0
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            print("HTML : \(myHTMLString)")
            
            var fullNameArr = myHTMLString.components(separatedBy:"###")
            
            for i in 0..<fullNameArr.count - 1 {
                print(i)
                var review = Review()
                
                var id = ""
                var reviewerPhone = ""
                var revieweePhone = ""
                var revieweeName = ""
                var comments = ""
                var stars = ""
                var holder  = fullNameArr[i].replacingOccurrences(of: "{\"", with: "", options: .literal, range: nil)
                holder  = holder.replacingOccurrences(of: "\"}", with: "", options: .literal, range: nil)
                holder = holder.replacingOccurrences(of: "\",\"", with: "###", options: .literal, range: nil)
                var fullNameArr3 = holder.components(separatedBy:"###")
                print(fullNameArr3[0].components(separatedBy:"\":\"").count)
                //   review.id = fullNameArr3[0].components(separatedBy:"\":\"")[1]
                review.reviewerPhone = fullNameArr3[1].components(separatedBy:"\":\"")[1]
                review.revieweePhone = fullNameArr3[2].components(separatedBy:"\":\"")[1]
                review.revieweeName = fullNameArr3[3].components(separatedBy:"\":\"")[1]
                review.comments = fullNameArr3[4].components(separatedBy:"\":\"")[1]
                review.stars = fullNameArr3[5].components(separatedBy:"\":\"")[1]
                review.date = fullNameArr3[6].components(separatedBy:"\":\"")[1]

                counter = counter + 1
                accumulater = accumulater + Double(review.stars)!
                
            }
            
            
            
            
            
            
        } catch let error {
            print("Error: \(error)")
        }
        if(counter == 0){
            return 0
        }
        return (accumulater / Double(counter))
        
    }
    
}
