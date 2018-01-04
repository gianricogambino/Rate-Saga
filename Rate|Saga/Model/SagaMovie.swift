//
//  SagaList.swift
//  Rate|Saga
//
//  Created by gianrico on 28/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import Foundation
import Firebase

class SagaMovie {
    var name: String
    var title: String
    var saga: String
    var votes: Int

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
}
