//
//  DetailViewController.swift
//  countries_n
//
//  Created by Nathan Beard on 2/9/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var countries = [String]()
    var selectedContinent = 0
    // QUESTION: Why is selectedContinent = 0? Updating title...
    
    var continentListDetail = Continents()
    var searchController : UISearchController!
    
    override func viewWillAppear(_ animated: Bool) {
        // QUESTION: This puts String data from Class Continents, continents PList (dictionary) into var
        continentListDetail.continents = Array(continentListDetail.continentData.keys) 
        let chosenContinent = continentListDetail.continents[selectedContinent]
        countries = continentListDetail.continentData[chosenContinent]! as [String]
        
        // Adding search controller:
        let resultsController = SearchResultsController() // QUESTION: Creating instance in order to see it? ... in order to access "allCountries"/class data
        resultsController.allCountries = countries
        print(resultsController.allCountries)
        searchController = UISearchController(searchResultsController: resultsController)
        // initializing searchController with new values resultsController
        
        // Search bar config: why manually and not on storyboard?
        searchController.searchBar.placeholder = "Search countries"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar // put search bar in header
        searchController.searchResultsUpdater = resultsController
        //initializes update: resultsController values = search results
        
    }
    
    /* QUESTION: What does this do?
     override func viewWillDisappear(_ animated: Bool) {
     print("view will disappear")
     }
    */
    
    // only runs the first time you access memory on app
    // need to use viewWillAppear because need data everytime you click on a continent
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        // can do this in the storyboard, but it wouldn't automatically call the right methods so easier in code
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row]
        return cell
    }
    
    

    // Override to support conditional editing of the table view.
    // For EDIT button (return false if you don't want to allow editing of certain rows?
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    // Handles deleting
    // If editing style is delete, then delete rows, or insert
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // Delete country from array (and master list so when the user goes back it's still not there)
            // countries = local variable denoting array
            countries.remove(at: indexPath.row)
            let chosenContinent = continentListDetail.continents[selectedContinent]
            // delete data from model
            // QUESTION: What does model mean? And what exactly is continentData? Is the the PList?
            continentListDetail.continentData[chosenContinent]?.remove(at: indexPath.row)
            
            // delete the row of the table
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    

    // QUESTION: I added "toIndexPath" to "to" parameter... is that right?
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let fromRow = fromIndexPath.row // constant = row being moved from
        let toRow = toIndexPath.row // row being moved to
        let moveCountry = countries[fromRow] // countries from row
        // move from array
        countries.remove(at: fromRow)
        countries.insert(moveCountry, at: toRow)
        
        let chosenContinent = continentListDetail.continents[selectedContinent]
        continentListDetail.continentData[chosenContinent]?.remove(at: fromRow)
        continentListDetail.continentData[chosenContinent]?.insert(moveCountry, at: toRow)
        

    }



    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    
    
    
    @IBAction func unwind(_ segue: UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            let source = segue.source as! AddCountryViewController // only add a country if there is text in textfield
            // QUESTION: Why casting as a ViewController? 
            // Is it so we can use the "addedCountry" string from that ViewController?
            if ((source.addedCountry.isEmpty) == false){
                countries.append(source.addedCountry)
                tableView.reloadData() // reloadData = instance function of tableView 
                let chosenContinent = continentListDetail.continents[selectedContinent]
                continentListDetail.continentData[chosenContinent]?.append(source.addedCountry)
                // if textfield is not empty, the countries string array adds text (addedCountry) to end of it
            }}
    }

}
