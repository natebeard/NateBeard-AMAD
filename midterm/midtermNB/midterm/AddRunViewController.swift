//
//  AddRunViewController.swift
//  midterm
//
//  Created by Nathan Beard on 3/16/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class AddRunViewController: UIViewController {

    @IBOutlet weak var addRunTextfield: UITextField!
    var addedRun = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            if ((addRunTextfield.text?.isEmpty) == false) {
                addedRun = addRunTextfield.text!
            }
        }
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
