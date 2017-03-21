//
//  DetailViewController.swift
//  harrypotter_n
//
//  Created by Nathan Beard on 2/28/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
                loadWebPage(detail as! String)
            }
        }
    }
    
    // default is NSDate. Change to AnyObject or String because the URL is a String...
    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }
    
    func loadWebPage(_ urlString: String){
        let myURL = URL(string: urlString)
        let request = URLRequest(url: myURL!)
        webView.loadRequest(request)
    }
    

    func webViewDidStartLoad(_ webView: UIWebView) {
        print("start load")
        webSpinner.startAnimating()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("stop load")
        webSpinner.stopAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }




}

