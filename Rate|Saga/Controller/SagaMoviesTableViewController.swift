//
//  SagaMoviesTableViewController.swift
//  Rate|Saga
//
//  Created by gianrico on 29/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import UIKit
import Firebase

class SagaMoviesTableViewController: UITableViewModification {
    
    let sagaMovieRef:DatabaseReference = Database.database().reference().child("sagas")
    var movieListItems:[SagaMovie] = []
    
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    var selectedSaga: SagaList? {
        didSet {
            loadMovies()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        transparentBackgroundController()
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
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
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
//                print("controllo selezione dati film")
//                print(self.selectedSaga?.saga as Any)
//                print(movie.saga)
                if movie.saga == self.selectedSaga?.saga {
                    self.movieListItems.append(movie)
                }
            }
            self.tableView.reloadData()
            self.navBarTitle.title = self.selectedSaga?.saga
        }
    }
}
