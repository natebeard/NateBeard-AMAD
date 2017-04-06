//
//  MasterViewController.swift
//  whitehouse_petitions
//
//  Created by Nathan Beard on 3/21/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [[String : String]]()

    // 1. get rid of insert new object function below
    // 2. viewdidload get rid of everything but super
    // 3. comment out or delete permit editing style and canEditRow
    // 4. change objects to array of dictionaries
    // 5. create method to bring in JSON file
    // 6. function to parse JSON
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadjoson()
    }
    
    func loadjoson(){
    let urlPath = "https://api.whitehouse.gov/v1/petitions.json?limit=50"
        guard let myurl = URL(string: urlPath)
        else{
            print("url error")
            return
        }
        
        let session = URLSession.shared.dataTask(with: myurl, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            /*
             if (statusCode == 200){
             //download successful
             dispatch_async(dispatch_get_main_queue()) {self.parsejson(data!)}
             }
             else {
             print("file download error")
             }
             */
            guard statusCode == 200
                else {
                    print("file download error")
                    return
            }
            //download successful
            print("download complete")
            // calls
            DispatchQueue.main.async {self.parsejson(data!)}
        })
        //must call resume to run session
        session.resume()
    }
    
    // populating objects array:
    func parsejson(_ data: Data){
        do {
            // get json data
            // can't cast as swift dictionary?
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            //get all results in array of dictionaries
            //
            let allresults = json["results"] as! [[String:Any]]
            
            //add results to objects
            // need for loop because need to go through array of dictionaries and grab values
            for result in allresults {
                //check that data exists
                guard let title = result["title"]! as? String,
                    let sigCount = result["signatureCount"] as? NSNumber,
                    let itemurl = result["url"]! as? String
                    else {
                        continue
                }
                //create new object
                let obj = ["title": title, "signature": sigCount.stringValue, "url": itemurl]
                //add object to array
                self.objects.append(obj)
            }
            //handle thrown error
        } catch {
            print("Error with JSON: \(error)")
            return
        }
        //reload the table data after the json data has been downloaded
        tableView.reloadData()
    }


    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let url = object["url"]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = url 
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                let title = object["title"]
                controller.title = title
            }
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = objects[indexPath.row]
        
        cell.textLabel!.text = object["title"]
        if object["signature"] != nil {
            cell.detailTextLabel!.text = object["signature"]! + " signature"
        }
        return cell
    }

    
    /*
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    */

}

