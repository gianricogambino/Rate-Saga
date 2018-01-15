//
//  SagaMoviesTableViewController.swift
//  Rate|Saga
//
//  Created by gianrico on 29/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class SagaMoviesTableViewController: UITableViewModification {
    
    // usaed for retrieve movie data
    let sagaMovieRef:DatabaseReference = Database.database().reference().child("sagas")
    // used to count how many movies are present in the selected saga
    var countMovie:Int = 0
    // array of Movie of class SagaMovie
    var movieListItems:[Saga] = []
    // IBOutlet unusefull - delete?
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var voteButton: UIBarButtonItem!
    @IBOutlet weak var madeYourListButton: UIBarButtonItem!
    
    //retrieve selected saga from class SagaTableViewControll
    var selectedSaga: Saga? {
        didSet {
            // 1 - launch loadMovies method to create the list
            loadMovies()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        transparentBackgroundController()
    }

    // MARK: - Tableview datasource
    // 3 - using the step 2 data in cell creation

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieListItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // inherit from UITableViewModification
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        //data modification on the loadMovie() method
        let movie = movieListItems[indexPath.row]
        print(movie)
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = String(movie.votes)
        
        //set the last item in the array equal to the number of element -1
        //so it's possible to verify  when the last cell is created  in order
        //to launch the populateVotesArray() Method
        let endIndex = movieListItems.endIndex-1
        if endIndex == indexPath.row  {
            countMovie = movieListItems.count
        }
        return cell
    }
    
    // MARK: - voting methods
    
    // 4 - user pressed VOTE button
    @IBAction func voteButtonPressed(_ sender: UIBarButtonItem) {
        
        // if isEditing is true isn't possible to vote the guard statement checks that condition
        guard tableView.isEditing else {
            
            for i in 0...(countMovie - 1) {
                //vote = numberOfElements - numberInThearray
                let expressedVote = countMovie - i
                //new sum of the previous values with the newone
                movieListItems[i].votes = movieListItems[i].votes + expressedVote
            }
            //invoke the saveVotes() methods passing movieListItems array
            saveVotes(movieItem: movieListItems)
            return
        }
    }
    
    
    //MARK: - editing cell methods
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        
        // modifify the top buttons on the isEditing status
        if tableView.isEditing {
            voteButton.tintColor = UIColor.flatGray()
            madeYourListButton.title = "Done"
        } else {
            voteButton.tintColor = UIColor(hexString: "FFD65A")
            madeYourListButton.title = "MadeYourList"
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }

    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // 6 - Editing methods to move up and down the rows
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveCell = movieListItems[sourceIndexPath.row]
        movieListItems.remove(at: sourceIndexPath.row)
        movieListItems.insert(moveCell, at: destinationIndexPath.row)
    }
    
    //MARK: - Model manipulation data methods
    
    // 2 - creation of the array containing the database info regarding the movies of the selectedSaga
    
    func loadMovies() {
        sagaMovieRef.observe(.value) { (dataSnapshot) in
            self.movieListItems.removeAll()
            for item in dataSnapshot.children {
                let movieList = item as! DataSnapshot
                let movie = Saga(sagaItems: movieList)
                // the if statement tells tht only the movies corresponding to the selectedSaga
                // will be visualized and appendend to the movieListItem array
                if movie.saga == self.selectedSaga?.saga {
                    self.movieListItems.append(movie)
                }
            }
            self.tableView.reloadData()
            self.navBarTitle.title = self.selectedSaga?.saga
        }
    }
    
    // 5 - saving methods
    
    func saveVotes(movieItem:[Saga]) {
        
        //FIRST saving cicle
        //here we save the votes to the sagaMovie node of the db
        
        for i in 0...(countMovie - 1) {
            //dictionary containing every single element in the node of FB db
            let elements = ["name":movieItem[i].name,"saga":movieItem[i].saga,"title":movieItem[i].title,"votes":movieItem[i].votes] as [String : Any]
            //update string in which we modify the node with the description equal to the .name property
            sagaMovieRef.child(movieItem[i].name).updateChildValues(elements)
        }
        
        //SECOND saving cicle
        //here we save the user and the saga he voted
        
        let votingDB = Database.database().reference().child("votedSagaByUser")
        let votingDict = ["user": Auth.auth().currentUser?.email as Any, "saga": selectedSaga?.saga as Any, "voted": true] as [String : Any]
        votingDB.childByAutoId().setValue(votingDict) { (error, reference) in
            if error != nil {
                print("error in saving userdata")
            } else {
                print("userdata saved check the db!")
            }
        }
    }
}
