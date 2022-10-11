//
//  WebViewController.swift
//  WanAndroidSwift
//  
//  Created by CoderSamz on 2022.
// 	
// 
    

import UIKit
import WebKit
import SVProgressHUD

class WebViewController: UIViewController {

    fileprivate var webView: WKWebView!
    var requestURL: String = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView2.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "loding...")
        if let request = URLRequest(urlString: requestURL) {

            webView.load(request)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }

}

extension WebViewController: WKNavigationDelegate {
    
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print("\(#function)")
//    }
//
//    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
//        print("\(#function)")
//    }
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        print("\(#function)")
//    }
//    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//        print("\(#function)")
//    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }

}
