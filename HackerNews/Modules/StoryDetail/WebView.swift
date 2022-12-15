//
//  WebView.swift
//  HackerNews
//
//  Created by ebpearls on 14/12/2022.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let urlString: String
    
    func makeUIView(context: Context) -> some WKWebView {
        guard let url = URL(string: urlString) else {
            return WKWebView.pageNotFound()
        }
        
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
}
