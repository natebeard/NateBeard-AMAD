//
//  ResortsTableViewController.swift
//  midterm
//
//  Created by Nathan Beard on 3/16/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class ResortsTableViewController: UITableViewController {

    var resortsList = Resorts()
    
    let kfilename = "data.plist"
    
    func getDataFile() -> String? {
        //use a Bundle object of the directory for our application to retrieve the pathname of continents.plist
        guard let pathString = Bundle.main.path(forResource: "resorts", ofType: "plist") else {
            return nil
        }
        return pathString
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        guard let path = getDataFile() else{
            print("Error loading file")
            return
        } */

        
        let path:String?
        let filePath = docFilePath(kfilename) //path to data file
        //print(filePath)
        
        // READING:
        // if the data file exists, use it
        if FileManager.default.fileExists(atPath: filePath!){
            path = filePath
            //print(path)
        }
        else {
            path = getDataFile()

        }
        
        resortsList.allData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        resortsList.resorts = Array(resortsList.allData.keys)
        
        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification (listening for that String)
        // if fired, launch application will resign function below
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
        

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
        return resortsList.allData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        cell.textLabel?.text = resortsList.resorts[indexPath.row]
        // Configure the cell...

        return cell
    }
    


     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "runsIdentifier" {
            let runsTV = segue.destination as! RunsTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!

            runsTV.title = resortsList.resorts[indexPath.row]
            runsTV.dataForRunsTV = resortsList
            runsTV.selectedResort = indexPath.row
        
        }}
    
    
    func docFilePath(_ filename: String) -> String?{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString
        return dir.appendingPathComponent(filename)
    }
    
    func applicationWillResignActive(_ notification: Notification){
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        data.addEntries(from: resortsList.allData)
        //print(data)
        //write the contents of the array to our plist file
        data.write(toFile: filePath!, atomically: true)
    }



    /*
     
     
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
