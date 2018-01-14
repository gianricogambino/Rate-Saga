//
//  VotedSagaByUser.swift
//  Rate|Saga
//
//  Created by gianrico on 07/01/18.
//  Copyright © 2018 gianrico. All rights reserved.
//

import Foundation
import Firebase

class VotedSagaByUser {
    var saga: String
    var user: String
    var voted: Bool
    
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
