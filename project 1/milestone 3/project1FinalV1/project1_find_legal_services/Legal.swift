//
//  Legal.swift
//  project1_find_legal_services
//
//  Created by Nathan Beard on 3/8/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import Foundation

class Resources {
    
    // this is where I got help from my friend
    var allDataServices: [String: [[String :String]]] // matches data in plist
    var serviceTypesArray: [String]
    var serviceTypesDictionary: [[String : String]]
    
    
    private static var savedPlistPath: String {
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString

        return dir.appendingPathComponent("data.plist")
    }
    
    
    // property of the class and not the instance
    private static var firstPlistPath: String {
        return Bundle.main.path(forResource: "services", ofType: "plist")!
    }
    
    // init in class
    init() {
        
        // if the data file exists, use it
        let path: String
        
        if FileManager.default.fileExists(atPath: Resources.savedPlistPath){
            path = Resources.savedPlistPath
        } else {
            path = Resources.firstPlistPath
            // if it doesn't exist, get access to plist that we have been using
        }
        
        // load data from services plist into dictionary, then put dictionary plist into legalList
        let services = NSDictionary(contentsOfFile: path) as! [String: [[String:String]]]
        
        allDataServices = services
        // create array made up of keys (the different services)
        serviceTypesArray = Array(services.keys)
        // create an empty array and loop through it to append content values 
        serviceTypesDictionary = []
        // QUESTION: Only need dictionary when adding new data?
        for service in services.values {
            serviceTypesDictionary.append(contentsOf: service)
            // can't cast because need to take out layer of arrays to get to values
        }
    }
    
    // function that adds new organizations from AddOrgVC 
    // and uses indexPath's title as key to input org name and url in the right array
    func addOrganization(service: String, name: String, url: String) {
        // take array of orgs out under whatever service it is
        // getting "service" String from title, and removes
        if var organizationsForService = allDataServices[service] {
            // add org name and url
            organizationsForService.append(["name":name, "url":url])
            // add it back to original
            allDataServices[service] = organizationsForService
        }
        
        let dataToSave = NSDictionary(dictionary: allDataServices)
        
        dataToSave.write(toFile: Resources.savedPlistPath, atomically: true)
    }
    
}










