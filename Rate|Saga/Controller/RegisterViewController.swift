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
        transparentNavigationController()
    }
    
    // MARK: - Navigation
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil {
                    print("PRIMO CONTROLLO - RegisterViewController - Errore in fase di registrazione: \(String(describing: error))")
                    SVProgressHUD.dismiss()
                } else {
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "gotoSagaSelector", sender: self)
                }
            }
        }
    }
