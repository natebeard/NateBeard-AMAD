//
//  OrgsTableViewController.swift
//  project1_find_legal_services
//
//  Created by Nathan Beard on 3/8/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class OrgsTableViewController: UITableViewController {


    var organizations: [[String:String]]!
    var orgList: Resources!

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
        // Add search controller here if needed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LegalOrg", for: indexPath)
        let orgName = organizations[indexPath.row]
        cell.textLabel?.text = orgName["name"]
        return cell
    }

    
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        if segue.identifier == "doneSegue" {
            let source = segue.source as! AddOrgViewController
            
            // This is where Luna started helping. 
            // Couldn't figure out how to add url and name to array specific to whatever list/indexPath the user is on
            if let name = source.addOrgNameTextfield.text, let url = source.addOrgURLTextfield.text, let title = title, !name.isEmpty && !url.isEmpty {
                // if both textfields are not empty
                // call addOrg func from Resources/orgList
                orgList.addOrganization(service: title, name: name, url: url)
                
                organizations = orgList.allDataServices[title]
                
                tableView.reloadData()
            }
        }
    }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "orgDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailOrg = organizations[indexPath.row]
                let url = detailOrg["url"]! as String
                print(url)
                let name = detailOrg["name"]! as String
                let orgInfoView = (segue.destination as! UINavigationController).topViewController as! DetailOrgsViewController
                orgInfoView.detailOrgURL = url as AnyObject?
                
                orgInfoView.title = name

            }
        }

     }

    
    /*
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // organizations.remove(at: indexPath.row)
            // if let: orgList.addOrganization(service: title, name: name, url: url)
            // remove at orgList.allDataServices[title]
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        } }
    */
    


}
