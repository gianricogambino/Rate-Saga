//
//  LoginViewController.swift
//  Rate|Saga
//
//  Created by gianrico on 27/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIModification {
    
    //MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupResponders(email: emailTextField, password: passwordtextField)
        transparentNavigationController()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            loginRateSaga()
        }
        // Do not add a line break
        return true
    }
    
    // MARK: - Navigation
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginRateSaga()
    }
    
    func loginRateSaga () {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordtextField.text!) { (user, error) in
            if error != nil {
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "gotoSagaSelector", sender: self)
            }
        }
    }

}
