//
//  AddViewController.swift
//  recipes_n
//
//  Created by Nathan Beard on 3/23/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var recipeName: UITextField!
    @IBOutlet weak var recipeURL: UITextField!
    
    var addedRecipe = String()
    var addedURL = String()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSegue" {
            if recipeName.text?.isEmpty == false {
                addedRecipe = recipeName.text!
                addedURL = recipeURL.text!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
