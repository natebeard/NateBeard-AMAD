//
//  AboutViewController.swift
//  pathos
//
//  Created by Siddharth on 4/7/17.
//  Copyright © 2017 pathos. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //On adding the left bar button item. title image got pushed to left. So added a
        //right bar button item in storyboard but tint is clear.
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        logoImageView.contentMode = .scaleAspectFit
        let logoImage = UIImage(named: "logo")
        logoImageView.image = logoImage
        navigationItem.titleView = logoImageView
       
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
