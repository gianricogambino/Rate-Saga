//
//  SagaMoviesTableViewController.swift
//  Rate|Saga
//
//  Created by gianrico on 29/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import UIKit
import Firebase

class SagaMoviesTableViewController: UITableViewController {
    
    let sagaMovieRef:DatabaseReference = Database.database().reference().child("sagas")
    var movieListItems:[SagaMovie] = []
    
    var selectedSaga: SagaList? {
        didSet {
            loadMovies()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieListItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SagaCell", for: indexPath)
        let movie = movieListItems[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
    
    //MARK: - Model manipulation data methods
    
    func loadMovies() {
        sagaMovieRef.observe(.value) { (dataSnapshot) in
            self.movieListItems.removeAll()
            for item in dataSnapshot.children {
                let movieList = item as! DataSnapshot
                let movie = SagaMovie(sagaItem: movieList)
                print("controllo selezione dati film")
                print(self.selectedSaga?.saga as Any)
                print(movie.saga)
                if movie.saga == self.selectedSaga?.saga {
                    self.movieListItems.append(movie)
                    print(self.movieListItems)
                }
            }
            self.tableView.reloadData()
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
