//
//  ViewController.swift
//  Peer Review
//
//  Created by Austin on 5/20/18.
//  Copyright © 2018 Austin. All rights reserved.
//

import UIKit

class MyReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
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
        
        
        let myView = UITableView(frame: CGRect(x: 0, y: navBar.frame.maxY, width: screenSize.width, height: screenSize.height - navBar.frame.height))
    
        
        self.view.addSubview(myView)
        
        
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
        return 0 // your number of cell here
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        
    }

    
    
}


