//
//  MasterViewController.swift
//  harrypotter_n
//
//  Created by Nathan Beard on 2/28/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    var characters = [[String : String]]()

    
    func getDataFile() -> String? {
        //use a Bundle object of the directory for our application to retrieve the pathname of artistalbums.plist
        guard let pathString = Bundle.main.path(forResource: "mariolist", ofType: "plist") else {
            return nil
        }
        return pathString
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let path = getDataFile() else {
            print("Error loading file")
            return
        }

        let alldata = NSDictionary(contentsOfFile: path) as! [String: [[String : String]]]

        if alldata.isEmpty == false {
            characters = Array(alldata["characters"]!)
        }
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let char = characters[indexPath.row]
                let url = char["url"]! as String
                let name = char["name"]! as String
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = url as AnyObject?
                controller.title = name
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let chars = characters[indexPath.row]
        cell.textLabel!.text = chars["name"]! as String
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }




}

