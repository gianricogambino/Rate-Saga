//
//  Saga.swift
//  Rate|Saga
//
//  Created by gianrico on 15/01/18.
//  Copyright © 2018 gianrico. All rights reserved.
//

import Foundation
import Firebase

class Saga {
    var name: String = ""
    var title: String = ""
    var saga: String = ""
    var votes: Int = 0
    var user: String = ""
    var voted: Bool = true

    //MARK: - Movies initialization
    
    init(title:String, name:String,saga:String, votes:Int) {
        self.name = name
        self.title = title
        self.saga = saga
        self.votes = votes
    }
    
    init(sagaItems sagaData:DataSnapshot) {
        let sagaItem = sagaData.value as! [String:Any]
        name = sagaItem["name"] as? String ?? "name error"
        title = sagaItem["title"] as? String ?? "title error"
        saga = sagaItem["saga"] as? String ?? "saga error"
        votes = sagaItem["votes"] as? Int ?? 0
    }
    
    //MARK: - Sagas initialization

    init(name:String) {
        self.saga = name
    }
    
    init(sagasList sagaData:DataSnapshot) {
        let sagaItem = sagaData.value as! [String:Any]
        saga = sagaItem["name"] as? String ?? "saga error"
    }
    
    //MARK: - Saga Voted by User initialization
    
    init(name:String,mail:String,voted:Bool) {
        self.saga = name
        self.user = mail
        self.voted = voted
    }
    
    init(snapshotName sagaVotedData:DataSnapshot) {
        let votedItem = sagaVotedData.value as! [String:Any]
        saga = votedItem["saga"] as? String ?? "saga error"
        user = votedItem["user"] as? String ?? "user error"
        voted = votedItem["voted"] as! Bool
    }
}
