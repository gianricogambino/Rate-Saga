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

    init(title:String, name:String,saga:String) {
        self.name = name
        self.title = title
        self.saga = saga
    }
    
    init(sagaItem sagaData:DataSnapshot) {
        let sagaItem = sagaData.value as! [String:Any]
        name = sagaItem["name"] as? String ?? "name error"
        title = sagaItem["title"] as? String ?? "title error"
        saga = sagaItem["saga"] as? String ?? "saga error"
    }
}
