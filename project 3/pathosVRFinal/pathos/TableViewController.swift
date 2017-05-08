//
//  TableViewController.swift
//  pathos
//
//  Created by Nathan Beard on 5/4/17.
//  Copyright © 2017 pathos. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    

    var experienceImages = [UIImage]()
    
    // trying to pass var
    var selectedRow: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        experienceImages = [#imageLiteral(resourceName: "beautifulhomebottonshape"), #imageLiteral(resourceName: "comingsoon")]
        
        
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        logoImageView.contentMode = .scaleAspectFit
        let logoImage = UIImage(named: "logo")
        logoImageView.image = logoImage
        navigationItem.titleView = logoImageView
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 180
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // v1
        return experienceImages.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.experienceImageView.image = experienceImages[indexPath.row]
        return cell
    }

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "vrView", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "vrView" {
            let experienceView = segue.destination as! ViewController
            experienceView.selectedRow = selectedRow
            experienceView.selectedImage = experienceImages[selectedRow!]

        }
    }

    


}
