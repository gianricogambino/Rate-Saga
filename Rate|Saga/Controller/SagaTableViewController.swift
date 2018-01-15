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

class SagaTableViewController: UITableViewModification {
    
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    let user = Auth.auth().currentUser?.email
    let sagaListRef:DatabaseReference = Database.database().reference().child("sagasList")
    let votedDB:DatabaseReference = Database.database().reference().child("votedSagaByUser")

    var sagaListItems:[SagaList] = []
    var votedSagaListByUsers:[VotedSagaByUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitle.title = "Saga|List"
        transparentBackgroundController()
        
        //retrieve data regarding voted sagas
        
        let queryVotedDB = votedDB.queryOrdered(byChild: "user").queryEqual(toValue: user)
        queryVotedDB.observe(.value) { (votedSagaSnapShot) in
            self.votedSagaListByUsers.removeAll()
            for items in votedSagaSnapShot.children {
                let votedSagaList = items as! DataSnapshot
                let votedSagaByUser = VotedSagaByUser(snapshotName: votedSagaList)
                self.votedSagaListByUsers.append(votedSagaByUser)
            }
            self.tableView.reloadData()
        }
        
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
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let saga = sagaListItems[indexPath.row]
        let votedArray = votedSagaListByUsers.count

        // if the votedSagaListByUsers array isn't empty the i row should be gray if is a voted saga
        if votedArray != 0  {
            for i in 0...votedSagaListByUsers.count-1 {
                if saga.saga == votedSagaListByUsers[i].saga {
                    cell.textLabel?.textColor = UIColor.flatGray()
                }
            }
        }
        
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
}
