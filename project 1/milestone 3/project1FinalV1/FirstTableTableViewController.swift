//
//  FirstTableTableViewController.swift
//  project1_find_legal_services
//
//  Created by Nathan Beard on 3/8/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class FirstTableTableViewController: UITableViewController {

    var legalList: Resources!
    // QUESTION: Resources/allDataServices is empty until initialized in viewDidLoad, but need it here why?

    
    // TO DO:
    // 1. remove toolbars
    // 2. fix constraints
    // 3. add delete rows and write up HOW IT FUCKING WORKS...
    // 4. edit out comments
    
    override func viewDidLoad() {
        super.viewDidLoad()

        legalList = Resources()
        
        // WRITING:
        // get access to shared application, then notification fired—sending writing data—if go to a different app
        //application instance
//        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification (listening for that String)
        // if fired, launch application will resign function below
//        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
        
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return legalList.allDataServices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LegalType", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = legalList.serviceTypesArray[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrgSegue" {
            let orgsVC = segue.destination as! OrgsTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            // update title with key from selected indexpath row
            orgsVC.title = legalList.serviceTypesArray[indexPath.row]
            // if used that key in title, can use it in sending organizations (names) to next view
            orgsVC.organizations = legalList.allDataServices[legalList.serviceTypesArray[indexPath.row]]
            
            orgsVC.orgList = legalList
            
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    


}
