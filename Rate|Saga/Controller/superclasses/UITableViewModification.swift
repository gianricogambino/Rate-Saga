//
//  UITableViewModification.swift
//  Rate|Saga
//
//  Created by gianrico on 31/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import Foundation
import UIKit

class UITableViewModification: UITableViewController {
    
    let backgroundImage = UIImage(named: "starwars-mask")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func transparentBackgroundController() {
        tableView.separatorStyle = .none
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
    }
    
    // MARK: - Tableview UI Methods
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SagaCell", for: indexPath)
        //colore del testo delle celle
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
}
