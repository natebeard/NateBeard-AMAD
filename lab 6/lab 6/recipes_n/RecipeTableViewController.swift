//
//  RecipeTableViewController.swift
//  recipes_n
//
//  Created by Nathan Beard on 3/23/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit
import Firebase

class RecipeTableViewController: UITableViewController {

    // 1. import and create var type for Firebase
    var ref: FIRDatabaseReference!
    // 3. create array to hold recipes:
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 2. Give database reference to firebase
        ref = FIRDatabase.database().reference()
        
        // 4. set up event listener for anytime there is a change in the firebase
        // Putting this in viewDidLoad
        // Firebase handles event listeners. Can't read data without an event listener (SQL doesn't do that)

        ref.observe(FIRDataEventType.value, with: {snapshot in
        self.recipes=[]
        //FIRDataSnapshot represents the Firebase data at a given time
        //gets all the child data nodes
        for recipe in snapshot.children.allObjects as! [FIRDataSnapshot]{
//            let item = recipe.value as! [String:String]
//            guard let recipeName = item["name"],
//                let recipeURL = item["url"]
//                else {
//                    continue
//            }
        //create new recipe object
            let newRecipe = Recipe(snapshot: recipe)
        //add recipe to recipes array
        self.recipes.append(newRecipe)
            }
            self.tableView.reloadData()
})

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return recipes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel!.text = recipe.name

        return cell
    }

    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "saveSegue" {
            let source = segue.source as! AddViewController
            if source.addedRecipe.isEmpty == false {
                //create new recipe object
                let newRecipe = Recipe(newname: source.addedRecipe, newurl: source.addedURL)
                //add recipe to recipes array
                recipes.append(newRecipe)
                //create Dictionary
                let newRecipeDict = ["name": source.addedRecipe, "url": source.addedURL]
                //create a child reference in Firebase where the key value is the recipe name
                let reciperef = ref.child(source.addedRecipe)
                //write data to Firebase
                reciperef.setValue(newRecipeDict)
            }
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
