//
//  ViewController.swift
//  Peer Review
//
//  Created by Austin on 5/20/18.
//  Copyright © 2018 Austin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screenSize: CGRect = UIScreen.main.bounds
        
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        myView.backgroundColor = UIColor.lightGray

        let myLabel = UILabel(frame: CGRect(x: 0, y: screenSize.height * 0.1, width: screenSize.width, height: screenSize.height * 0.1))
        myLabel.text = "Enter your Phone Number.  Don't worry, we will never distribute it or contact you."
        myLabel.lineBreakMode = .byWordWrapping
        myLabel.numberOfLines = 0
        myLabel.textAlignment = .center
        myLabel.font = myLabel.font.withSize(30)
//        myLabel.adjustsFontSizeToFitWidth = true
//        myLabel.minimumScaleFactor = 0.2
        myView.addSubview(myLabel)
        
        
        let mySmallerLabel = UILabel(frame: CGRect(x: 20, y: myLabel.frame.maxY + 10, width: screenSize.width - 40, height: screenSize.height * 0.1))
        mySmallerLabel.text = "(Don't worry, we will never distribute it or contact you)"
        mySmallerLabel.lineBreakMode = .byWordWrapping
        mySmallerLabel.numberOfLines = 0
        mySmallerLabel.textAlignment = .center
        mySmallerLabel.font = mySmallerLabel.font.withSize(15)

        //        myLabel.adjustsFontSizeToFitWidth = true
        //        myLabel.minimumScaleFactor = 0.2
        myView.addSubview(mySmallerLabel)
        
        
        let myTextField = UITextField(frame: CGRect(x: 25, y: mySmallerLabel.frame.maxY + 10, width: screenSize.width - 50, height: screenSize.height * 0.05))
        myTextField.placeholder = "(123)-456-7890"
        myTextField.font = UIFont.systemFont(ofSize: 15)
        myTextField.borderStyle = UITextBorderStyle.roundedRect
        myTextField.autocorrectionType = UITextAutocorrectionType.no
        myTextField.keyboardType = UIKeyboardType.default
        myTextField.returnKeyType = UIReturnKeyType.done
        myTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        myTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        myTextField.delegate = self
        myView.addSubview(myTextField)

        
        let myButton = UIButton(frame: CGRect(x: 25, y: myTextField.frame.maxY + 40, width: screenSize.width - 50, height: screenSize.height * 0.05))
        myButton.setTitle("Next", for: .normal)
        myButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        myView.addSubview(myButton)
        

        self.view.addSubview(myView)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func buttonAction(sender: UIButton!) {
        performSegue(withIdentifier: "phoneToProfile", sender: nil)
    }


}

extension ViewController: UITextFieldDelegate {
    
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
