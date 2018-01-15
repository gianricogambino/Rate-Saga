//
//  UIModification.swift
//  Rate|Saga
//
//  Created by gianrico on 27/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD

class UIModification: UIViewController, UITextFieldDelegate {
    
    var email:UITextField!
    var password:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - NavigationController UI Methods
    
    func transparentNavigationController() {
        
        guard let navBar = self.navigationController?.navigationBar else {
            fatalError("Navigation controller does not exists")
        }
        
        guard let navView = self.navigationController?.view else {
            fatalError("Navigation controller view does not exists")
        }
        
        // Made navigationController transparent
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        navView.backgroundColor = nil
        navBar.tintColor = UIColor.flatYellow()
        navBar.barTintColor = UIColor.clear
        setToolbarItems(toolbarItems, animated: true)
        
    }
    
    //MARK: - textfields responder methods
    
    //setup responder to pass from a textfield to another
    func setupResponders(email:UITextField,password:UITextField) {
        email.delegate = self
        email.tag = 0
        password.delegate = self
        password.tag = 1
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
