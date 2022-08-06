//
//  WebViewController.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/05.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var movieURLINfo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openWebPage(url: movieURLINfo)
    }
    
    func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        print("\(movieURLINfo)나웹이에요")
        webView.load(request)
    }
    
}
