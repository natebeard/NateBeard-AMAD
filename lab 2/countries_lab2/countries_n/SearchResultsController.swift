//
//  SearchResultsController.swift
//  countries_n
//
//  Created by Nathan Beard on 2/21/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating {

    // store all words + search results
    var allCountries = [String]()
    var resultCountries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // no scene for search, so need to identify it
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
    }
    
    // required method for search tableView
    func updateSearchResults(for searchController: UISearchController) {
        print(allCountries)
        let searchString = searchController.searchBar.text // variable holding text user types in
        resultCountries.removeAll(keepingCapacity: true) // removes everything from array—keeping searchString
        if searchString?.isEmpty == false {
            let filter: (String) -> Bool = { name in
                // QUESTION: What is the closure we're passing here? Explain?
                // QUESTION: How would I find out "range" and fact that I need to set up this function like it is?
                let range = name.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
                return range != nil
            } //end closure: returns true if the value matches and false if there’s no match (as long as it does not return nil
            // look up range functions to find filter function returning array based on whatever closuer passed (defined in range constant)
            let matches = allCountries.filter(filter) // how this vs. what pops up when typing?
            resultCountries.append(contentsOf: matches)
        } // reload table:
        tableView.reloadData()
        //print(allCountries)
        //print(resultCountries)
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
        // SearchResultsController = subclass of UITableViewController so automatically acts as the table’s data source
        return resultCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = resultCountries[indexPath.row]
        return cell
    }

    

}










