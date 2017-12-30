//
//  SagaTableViewController.swift
//  Rate|Saga
//
//  Created by gianrico on 27/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class SagaTableViewController: UITableViewController {
    
    //let sagas = ["Star Wars","Harry Potter","Back to the Future","Indiana Jones"]
    let sagaListRef:DatabaseReference = Database.database().reference().child("sagasList")
    
    var sagaListItems:[SagaList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //codice tratto da testFirebase di HidranArias
        //listener asincrono
        sagaListRef.observe(.value) { (dataSnapShot) in
            self.sagaListItems.removeAll()
            for item in dataSnapShot.children {
                let sagaList = item as! DataSnapshot
                let saga = SagaList(sagaName: sagaList)
                self.sagaListItems.append(saga)
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Tableview data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sagaListItems.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SagaCell", for: indexPath)
        let saga = sagaListItems[indexPath.row]
        cell.textLabel?.text = saga.saga

        return cell
    }
    
    //MARK: - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoSagaMovies", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SagaMoviesTableViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedSaga = sagaListItems[indexPath.row]
        }
    }
    
    //MARK: - Tabbar Methods
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
