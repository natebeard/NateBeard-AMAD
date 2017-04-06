//
//  DetailViewController.swift
//  whitehouse_petitions
//
//  Created by Nathan Beard on 3/21/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {


    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!

    var detailItem: String?

    func configureView() {
        // Update the user interface for the detail item: don't use self.detailItem
        if let detail = detailItem {
            loadWebPage(detail)
        }
    }
    
    func loadWebPage(_ urlString: String) {
        let myurl2 = URL(string: urlString)
        let request = URLRequest(url: myurl2!)
        webView.loadRequest(request)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        self.configureView()
    }
    
    //UIWebViewDelegate method that is called when a web page begins to load
    func webViewDidStartLoad(_ webView: UIWebView) {
        webSpinner.startAnimating()
    }
    
    //UIWebViewDelegate method that is called when a web page loads successfully
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webSpinner.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // Get an error here because you call detailItem/configureView from MasterViewController before webView
    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }*/



}

