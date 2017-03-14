//
//  DetailOrgsViewController.swift
//  project1_find_legal_services
//
//  Created by Nathan Beard on 3/9/17.
//  Copyright © 2017 natebeard_. All rights reserved.
//

import UIKit

class DetailOrgsViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView?
    
    var detailOrgURL: AnyObject? {
        didSet {
            self.configureView()
        }
    }
    
    func configureView() {
        if let detail = self.detailOrgURL {
            loadWebPage(detail as! String)
        }
    }
    
    func loadWebPage (_ urlString: String) {
        let myurl = URL(string: urlString)
        let request = URLRequest(url: myurl!)
        webView?.loadRequest(request)
    }
    
    //UIWebViewDelegate method that is called when a web page begins to load
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("start load")
        webSpinner.startAnimating()
    }
    //UIWebViewDelegate method that is called when a web page loads successfully
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("stop load")
        webSpinner.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
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
