//
//  WebViewControllerViewController.swift
//  DisneyCharacter
//
//  Created by Андрей Сорокин on 29.01.2025.
//

import UIKit
import WebKit

class WebViewControllerViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Properties
    
    var url: String?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebPage(url)
        title = "Web View Page"
    }
    
    // MARK: - Private method
    
    private func loadWebPage(_ urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString)
        else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
