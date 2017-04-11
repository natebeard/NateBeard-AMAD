//
//  Recipe.swift
//  recipes_n
//
//  Created by Nathan Beard on 3/23/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import Foundation
import Firebase

class Recipe {
    // 1. create variable types to hold data key and value
    var name: String
    var url: String
    
    // 3. need to init for new data - pass a string for both the new name
    init(newname: String, newurl: String){
        name = newname
        url = newurl
    }
    
    // 2. init firebae class 
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: String]
        name = snapshotValue["name"]!
        url = snapshotValue["url"]!
    }
}
