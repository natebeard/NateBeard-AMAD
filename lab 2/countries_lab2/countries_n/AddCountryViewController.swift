//
//  AddCountryViewController.swift
//  countries_n
//
//  Created by Nathan Beard on 2/16/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class AddCountryViewController: UIViewController {

    
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var continentLabel: UILabel!
    
    
    // add String to store the new country added
    var addedCountry = String()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            // only adding a country if there is text in countryTextField
            if ((countryTextfield.text?.isEmpty) == false) {
                addedCountry = countryTextfield.text!
            }
        }
    }
    
    
    // QUESTION: Why do we add a navigation controller?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
