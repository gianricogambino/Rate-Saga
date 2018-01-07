//
//  RegisterViewController.swift
//  Rate|Saga
//
//  Created by gianrico on 27/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIModification {
    
    //MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupResponders(email: emailTextField, password: passwordTextField)
        transparentNavigationController()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            registerRateSaga()
        }
        // Do not add a line break
        return true
    }
    
    // MARK: - Navigation
    @IBAction func registerButtonPressed(_ sender: UIButton) {
            registerRateSaga()
            }
    
    func registerRateSaga() {
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "gotoSagaSelector", sender: self)
            }
        }
    }
}
