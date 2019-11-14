//
//  FullArticleViewController.swift
//  NYT
//
//  Created by Alex Lebedev on 13.11.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import WebKit

class FullArticleViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var webKitView: WKWebView!
    @IBOutlet weak var activityIndicatorOutlet: UIActivityIndicatorView!
    
    // MARK: - Properties
    var link: String?
    
    
    // MARK: - LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webKitView.navigationDelegate = self
        webKitView.uiDelegate = self
        showArticle()
    }
    
    // MARK: - Private methods
    private func showArticle() {
        activityIndicatorOutlet.startAnimating()
           let url = URL(string: link!)
           let request = URLRequest(url: url!)
           webKitView.load(request)
    }

}

// MARK: - Extensions
extension FullArticleViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
          activityIndicatorOutlet.stopAnimating()
    }
}

