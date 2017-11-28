//
//  DetailedViewController.swift
//  xiphiastecProject
//
//  Created by admin on 11/27/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import WebKit

class DetailedViewController: UIViewController {

    @IBOutlet private var labelTitle : UILabel!
    
    @IBOutlet private var labelDate : UILabel!
    
    @IBOutlet private var webView : WKWebView!
    
    private var item : ItemEntity?
    
    private var activityIndicator : UIActivityIndicatorView?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setValues()
    }

    
    // Set Items in View
    
    func set(item : ItemEntity){
        
        self.item = item        
        
    }
    
    // Load View Controller Values
    
    private func setValues(){
        
        self.labelTitle.text = item?.title
        self.labelDate.text = item?.publishedDate
        
        let url = "<iframe width=\"\(100)%\" height=\"\(100)%\" src=\"https://www.youtube.com/embed/\(item?.videoId ?? "")?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>"
        
        print(url)
        
        self.webView.navigationDelegate = self
        
        self.webView.loadHTMLString(url, baseURL: nil)
        
        self.activityIndicator = showActivity(inView: self.webView)
        
    }
    
    // Hide Activity Indicator
    
    private func hideLoaders(){
        
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
        
    }
    

}

extension DetailedViewController : WKNavigationDelegate {
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print("Completed")
        self.hideLoaders()
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        print("Error ", error.localizedDescription)
        
        let alert = showAlert(message: error.localizedDescription, type: .alert)
        
        DispatchQueue.main.async {
            
            self.present(alert, animated: true, completion: {
                self.hideLoaders()
            })
            
        }
        
    }
    
    
}
