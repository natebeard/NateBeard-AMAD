//
//  RunsTableViewController.swift
//  midterm
//
//  Created by Nathan Beard on 3/16/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class RunsTableViewController: UITableViewController {

    var runs = [String]()
    var selectedResort = 0
    var dataForRunsTV = Resorts()
    
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataForRunsTV.resorts = Array(dataForRunsTV.allData.keys)
        let chosenResort = dataForRunsTV.resorts[selectedResort]
        runs = dataForRunsTV.allData[chosenResort]! as [String]
        
        let resultsController = SearchTableViewController()
        resultsController.allwords = runs
        searchController = UISearchController(searchResultsController: resultsController)
        
        searchController.searchBar.placeholder = "Search runs"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView=searchController.searchBar
        searchController.searchResultsUpdater = resultsController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return runs.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = runs[indexPath.row]
        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            runs.remove(at: indexPath.row)
            let chosenResort = dataForRunsTV.resorts[selectedResort]
            dataForRunsTV.allData[chosenResort]?.remove(at: selectedResort)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        if segue.identifier == "doneSegue" {
            let sourceOfData = segue.source as! AddRunViewController
            if ((sourceOfData.addedRun.isEmpty) == false) {
                runs.append(sourceOfData.addedRun)
                tableView.reloadData()
                let chosenResort = dataForRunsTV.resorts[selectedResort]
                dataForRunsTV.allData[chosenResort]?.append(sourceOfData.addedRun)
            }
        }
    }
    

    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }*/
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



}
