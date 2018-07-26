//
//  ViewController.swift
//  Peer Review
//
//  Created by Austin on 5/20/18.
//  Copyright © 2018 Austin. All rights reserved.
//

import UIKit


class EditProfileViewController: UIViewController {
    var textfield: UITextField?
    var textfield2: UITextView?
    var textfield3: UITextField?
    var slider: UISlider?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screenSize: CGRect = UIScreen.main.bounds
        
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "MyKey")
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
                
                
            }
        } catch let error {
            print("Error: \(error)")
        }
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        
        let myLabel = UILabel(frame: CGRect(x: 0, y: screenSize.height * 0.1, width: screenSize.width, height: screenSize.height * 0.1))
        if(name != ""){
            myLabel.text = "Edit Profile"

        }else{
            myLabel.text = "Create Profile"

        }
        myLabel.lineBreakMode = .byWordWrapping
        myLabel.numberOfLines = 0
        myLabel.textAlignment = .center
        myLabel.font = myLabel.font.withSize(30)
        //        myLabel.adjustsFontSizeToFitWidth = true
        //        myLabel.minimumScaleFactor = 0.2
        myView.addSubview(myLabel)
        
        
        let mySmallerLabel = UILabel(frame: CGRect(x: 20, y: myLabel.frame.maxY + 10, width: screenSize.width - 40, height: screenSize.height * 0.1))
        mySmallerLabel.text = "What is your name?"
        mySmallerLabel.lineBreakMode = .byWordWrapping
        mySmallerLabel.numberOfLines = 0
        mySmallerLabel.textAlignment = .center
        mySmallerLabel.font = mySmallerLabel.font.withSize(15)
        
        //        myLabel.adjustsFontSizeToFitWidth = true
        //        myLabel.minimumScaleFactor = 0.2
        myView.addSubview(mySmallerLabel)

        
        
        let myTextField = UITextField(frame: CGRect(x: 25, y: mySmallerLabel.frame.maxY + 10, width: screenSize.width - 50, height: screenSize.height * 0.05))
        if(name != ""){
            myTextField.text = name

        }else{
            myTextField.placeholder = "John Johnson"

        }
        myTextField.font = UIFont.systemFont(ofSize: 15)
        myTextField.borderStyle = UITextBorderStyle.roundedRect
        myTextField.autocorrectionType = UITextAutocorrectionType.no
        myTextField.keyboardType = UIKeyboardType.default
        myTextField.returnKeyType = UIReturnKeyType.done
        myTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        myTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        myTextField.delegate = self
        self.textfield = myTextField
        myView.addSubview(myTextField)
        
        let mySmallerLabel2 = UILabel(frame: CGRect(x: 20, y: myTextField.frame.maxY + 10, width: screenSize.width - 40, height: screenSize.height * 0.1))
        mySmallerLabel2.text = "Tell us about yourself!"
        mySmallerLabel2.lineBreakMode = .byWordWrapping
        mySmallerLabel2.numberOfLines = 0
        mySmallerLabel2.textAlignment = .center
        mySmallerLabel2.font = mySmallerLabel2.font.withSize(15)
        
        //        myLabel.adjustsFontSizeToFitWidth = true
        //        myLabel.minimumScaleFactor = 0.2
        myView.addSubview(mySmallerLabel2)
        
        let myTextField2 = UITextView(frame: CGRect(x: 25, y: mySmallerLabel2.frame.maxY + 10, width: screenSize.width - 50, height: screenSize.height * 0.2))
        if(about != ""){
            myTextField2.text = about

        }
        //myTextField2.text = "(123)-456-7890"
        myTextField2.font = UIFont.systemFont(ofSize: 15)
        myTextField2.autocorrectionType = UITextAutocorrectionType.no
        myTextField2.keyboardType = UIKeyboardType.default
        myTextField2.returnKeyType = UIReturnKeyType.done
        myTextField2.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        myTextField2.layer.borderWidth = 1.0;
        myTextField2.layer.cornerRadius = 5.0;
        self.textfield2 = myTextField2
        
        myView.addSubview(myTextField2)
        

        
        
        

        
        
        let myButton = UIButton(frame: CGRect(x: screenSize.width / 4, y: myTextField2.frame.maxY + 40, width: screenSize.width / 4, height: screenSize.height * 0.05))
        myButton.setTitle("Cancel", for: .normal)
        if(name != ""){
            myButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)

        }else{
            myButton.addTarget(self, action: #selector(cancelAction2), for: .touchUpInside)

        }
        myButton.setTitleColor(UIColor.blue, for: .normal)
        
        myView.addSubview(myButton)
        
        
        let myButton2 = UIButton(frame: CGRect(x: (screenSize.width / 4) * 2, y: myTextField2.frame.maxY + 40, width: screenSize.width / 4, height: screenSize.height * 0.05))
        myButton2.setTitle("Save", for: .normal)
        myButton2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        myButton2.setTitleColor(UIColor.blue, for: .normal)
        
        myView.addSubview(myButton2)
        
        let myButton3 = UIButton(frame: CGRect(x: (screenSize.width / 2) - ((screenSize.width / 2) / 2), y: myButton2.frame.maxY + 20, width: screenSize.width / 2, height: screenSize.height * 0.05))
        myButton3.setTitle("Change Phone Number", for: .normal)
        myButton3.addTarget(self, action: #selector(cancelAction2), for: .touchUpInside)
        myButton3.setTitleColor(UIColor.blue, for: .normal)
        myButton3.titleLabel?.font = UIFont.systemFont(ofSize: 12)

        myView.addSubview(myButton3)
        
        
        self.view.addSubview(myView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print(self.textfield?.text)
        var name = self.textfield?.text!
        var about = self.textfield2?.text!
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "MyKey")
        
        if let encoded = "http://www.prettygoodsports.com/write/peerreviewProfile.php?name=\(name!)&about=\(about!)&phone=\(token ?? "0")".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let myURL = URL(string: encoded) {
            print(myURL)
            let task = URLSession.shared.dataTask(with: myURL) {(data, response, error) in
                print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
            }
            
            task.resume()
        }
        


        
        
        
        
        performSegue(withIdentifier: "editProfileToProfile", sender: nil)
    }
    
    @objc func cancelAction(sender: UIButton!) {
        performSegue(withIdentifier: "editProfileToProfile", sender: nil)
    }
    @objc func cancelAction2(sender: UIButton!) {
        performSegue(withIdentifier: "editProfileToPhone", sender: nil)
    }
    
    
}

extension EditProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }
    
}
