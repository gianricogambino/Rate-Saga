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
        transparentNavigationController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordtextField.text!) { (user, error) in
            if error != nil {
                print("PRIMO CONTROLLO - LoginViewController - Errore in fase di login: \(String(describing: error))")
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "gotoSagaSelector", sender: self)
            }
        }
    }
    
    

}
