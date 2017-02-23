//
//  ViewController.swift
//  countries_n
//
//  Created by Nathan Beard on 2/9/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var continentList = Continents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = getDataFile() else{
            print("Error loading file")
            return
        }
        //load the data of the plist file into the dictionary
        continentList.continentData = NSDictionary(contentsOfFile: path) as! [String : [String]]
        //puts all the continents in an array
        continentList.continents = Array(continentList.continentData.keys)
    }
    
    func getDataFile() -> String? {
        guard let pathString = Bundle.main.path(forResource: "continents", ofType: "plist") else {
            return nil
        }
        return pathString
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continentList.continentData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = continentList.continents[indexPath.row]
        return cell
    }
    
    
    // Send what row was selected and which countries to show
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "countrysegue" {
            let detailVC = segue.destination as! DetailViewController
            // want to cast as detailViewController because we need to access properties in order to get data
            // saving it in constant called detailVC
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            // saved the cell they clicked in indexPath
            //sets the data for the destination controller
            detailVC.title = continentList.continents[indexPath.row]
            detailVC.continentListDetail=continentList
            detailVC.selectedContinent = indexPath.row
        }
        // last thing: adding segue to continent info view
        else if segue.identifier == "continentSegue" {
                let infoVC = segue.destination as! ContinentInfoTableViewController
                // downcasting to because ContinentInfoTableViewController is a subclass of TableViewController
                // and need to use "name" and "number"
                let editingCell = sender as! UITableViewCell
                let indexPath = tableView.indexPath(for: editingCell)
                infoVC.name = continentList.continents[indexPath!.row]
                let countries = continentList.continentData[infoVC.name]! as [String]
                infoVC.number = String(countries.count)
        }
    }
    
    

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

