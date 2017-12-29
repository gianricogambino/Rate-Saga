//
//  SagaList.swift
//  Rate|Saga
//
//  Created by gianrico on 28/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import Foundation
import Firebase

class SagaList {
    var saga: String
    
    init(name:String) {
        self.saga = name
    }
    
    init(sagaName sagaData:DataSnapshot) {
        let sagaItem = sagaData.value as! [String:Any]
        saga = sagaItem["name"] as? String ?? "saga error"
    }
}

