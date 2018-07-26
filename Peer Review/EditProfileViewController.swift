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
        
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        
        let myLabel = UILabel(frame: CGRect(x: 0, y: screenSize.height * 0.1, width: screenSize.width, height: screenSize.height * 0.1))
        myLabel.text = "Edit Profile"
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
        myTextField.placeholder = "John Johnson"
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
        myButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        myButton.setTitleColor(UIColor.blue, for: .normal)
        
        myView.addSubview(myButton)
        
        
        let myButton2 = UIButton(frame: CGRect(x: (screenSize.width / 4) * 2, y: myTextField2.frame.maxY + 40, width: screenSize.width / 4, height: screenSize.height * 0.05))
        myButton2.setTitle("Save", for: .normal)
        myButton2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        myButton2.setTitleColor(UIColor.blue, for: .normal)
        
        myView.addSubview(myButton2)
        
        
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
        let url = URL(string: "http://www.prettygoodsports.com/write/peerreviewProfile.php?name=\(name!)&about=\(about!)&phone=\(token ?? "0")")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
        }
        
        task.resume()
        
        
        
        
        performSegue(withIdentifier: "editProfileToProfile", sender: nil)
    }
    
    @objc func cancelAction(sender: UIButton!) {
        performSegue(withIdentifier: "editProfileToProfile", sender: nil)
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
