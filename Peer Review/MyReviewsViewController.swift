//
//  ViewController.swift
//  Peer Review
//
//  Created by Austin on 5/20/18.
//  Copyright © 2018 Austin. All rights reserved.
//

import UIKit

class MyReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var reviews = [Review]()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screenSize: CGRect = UIScreen.main.bounds
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 10, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "Reviews by Me")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(done))
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: nil, action: #selector(add))

        navItem.leftBarButtonItem = doneItem
        navItem.rightBarButtonItem = addItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: navBar.frame.maxY, width: screenSize.width, height: screenSize.height - navBar.frame.height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "MyKey")

        let myURLString = "http://prettygoodsports.com/write/PeerReviewByPhone.php?phone=\(token! ?? "0")"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
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
                review.date = fullNameArr3[6].components(separatedBy:"\":\"")[1].components(separatedBy:" ")[0]
                var dateholder = review.date.components(separatedBy:"-")
                let last4 = dateholder[0].substring(from:dateholder[0].index(dateholder[0].endIndex, offsetBy: -2))
                
                review.date = "\(dateholder[1])/\(dateholder[2])/\(last4)"
                reviews.append(review)
            }

                

                
                
            
        } catch let error {
            print("Error: \(error)")
        }
        
        
tableView.reloadData()
        
        
        
    }

    @objc func done() { // remove @objc for Swift 3
        performSegue(withIdentifier: "myReviewsToProfile", sender: nil)

    }
    @objc func add() { // remove @objc for Swift 3
        performSegue(withIdentifier: "addReview", sender: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonAction(sender: UIButton!) {
        performSegue(withIdentifier: "phoneToProfile", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count // your number of cell here
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        let screenSize: CGRect = UIScreen.main.bounds
        
        var datelabel = UILabel(frame: CGRect(x: 10, y: 25, width: screenSize.width / 3, height: 15))
        datelabel.text = "\(reviews[indexPath.row].date)"
        cell.addSubview(datelabel)
        
        if(reviews[indexPath.row].revieweeName != ""){
            var label = UILabel(frame: CGRect(x: datelabel.frame.maxX  , y: 12, width: screenSize.width / 3, height: 15))
            label.text = "\(reviews[indexPath.row].revieweeName)"
            cell.addSubview(label)
            
            var label2 = UILabel(frame: CGRect(x: datelabel.frame.maxX , y: 32, width: screenSize.width / 3, height: 15))
            label2.text = "\(reviews[indexPath.row].revieweePhone)"
            cell.addSubview(label2)
        }else{
            var label = UILabel(frame: CGRect(x: datelabel.frame.maxX , y: 25, width: screenSize.width / 3, height: 15))
            label.text = "\(reviews[indexPath.row].revieweePhone)"
            cell.addSubview(label)
        }
        
        var label = UILabel(frame: CGRect(x: screenSize.width - (screenSize.width / 4), y: 25, width: screenSize.width / 4, height: 15))
        label.text = "\(reviews[indexPath.row].stars)"
        cell.addSubview(label)

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        let defaults = UserDefaults.standard
        defaults.set(reviews[indexPath.row].revieweePhone, forKey: "MyKey2")
        performSegue(withIdentifier: "myReviewsToViewProfile", sender: nil)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
}

class Review {
    var id: String = ""
    var reviewerPhone: String = ""
    var revieweePhone: String = ""
    var revieweeName: String = ""
    var comments: String = ""
    var stars: String = ""
    var date: String = ""
}
