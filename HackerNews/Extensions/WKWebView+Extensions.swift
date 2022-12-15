//
//  WKWebView+Extensions.swift
//  HackerNews
//
//  Created by ebpearls on 15/12/2022.
//

import Foundation
import WebKit

extension WKWebView {
    
    static func pageNotFound() -> WKWebView {
        let webView = WKWebView()
        let page = "<html><body><h1>Page Not Found!</h1></body></html>"
        webView.loadHTMLString(page, baseURL: nil)
        return webView
    }
    
}
