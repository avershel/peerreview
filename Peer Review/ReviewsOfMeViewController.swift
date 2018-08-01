//
//  ViewController.swift
//  Peer Review
//
//  Created by Austin on 5/20/18.
//  Copyright © 2018 Austin. All rights reserved.
//

import UIKit

class ReviewsOfMeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var reviews = [Review]()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screenSize: CGRect = UIScreen.main.bounds
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 10, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "Reviews of Me")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(done))
        
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: navBar.frame.maxY, width: screenSize.width, height: screenSize.height - navBar.frame.height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "MyKey")
        
        let myURLString = "http://prettygoodsports.com/write/PeerReviewOfPhone.php?phone=\(token! ?? "0")"
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
                
                reviews.append(review)
            }
            
            
            
            
            
            
        } catch let error {
            print("Error: \(error)")
        }
        
        
        tableView.reloadData()
        
        
        
    }
    
    @objc func done() { // remove @objc for Swift 3
        performSegue(withIdentifier: "reviewsOfMeToProfile", sender: nil)
        
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
        if(reviews[indexPath.row].reviewerPhone != ""){
            var label = UILabel(frame: CGRect(x: 5, y: 5, width: screenSize.width / 4, height: 15))
            label.text = "\(reviews[indexPath.row].revieweeName)"
            cell.addSubview(label)
            
            var label2 = UILabel(frame: CGRect(x: 10, y: 25, width: screenSize.width / 2, height: 15))
            label2.text = "\(reviews[indexPath.row].reviewerPhone)"
            cell.addSubview(label2)
        }else{
            var label = UILabel(frame: CGRect(x: 5, y: 5, width: screenSize.width / 2, height: 15))
            label.text = "\(reviews[indexPath.row].reviewerPhone)"
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
        defaults.set(reviews[indexPath.row].reviewerPhone, forKey: "MyKey2")
        performSegue(withIdentifier: "reviewsOfMeToViewProfile", sender: nil)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
}


