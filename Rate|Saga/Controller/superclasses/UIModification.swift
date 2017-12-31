//
//  UIModification.swift
//  Rate|Saga
//
//  Created by gianrico on 27/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import Foundation
import UIKit

class UIModification: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func transparentNavigationController() {
        
        guard let navBar = self.navigationController?.navigationBar else {
            fatalError("Navigation controller does not exists")
        }
        
        guard let navView = self.navigationController?.view else {
            fatalError("Navigation controller view does not exists")
        }
        
        // Rende trasparente il navigationController
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        navView.backgroundColor = nil
        navBar.tintColor = UIColor.flatYellow()
        navBar.barTintColor = UIColor.clear
        setToolbarItems(toolbarItems, animated: true)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
