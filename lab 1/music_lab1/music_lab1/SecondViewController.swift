//
//  SecondViewController.swift
//  music_lab1
//
//  Created by Nathan Beard on 2/2/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBAction func goToMusic(_ sender: UIButton) {
        if(UIApplication.shared.canOpenURL(URL(string: "spotify://")!)){
            UIApplication.shared.open(URL(string: "spotify://")!, options: [:], completionHandler: nil)
        } else {
            if(UIApplication.shared.canOpenURL(URL(string: "music://")!)){
                UIApplication.shared.open(URL(string: "music://")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(URL(string:"http://www.apple.com/music/")!, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

