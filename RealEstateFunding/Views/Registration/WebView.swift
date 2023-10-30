//
//  WebView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 25.10.2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let webConfiguration = WKWebViewConfiguration()
    
    func makeUIView(context: Context) -> WKWebView {
        webConfiguration.applicationNameForUserAgent = "Version/8.0.2 Safari/600.2.5"

        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.load(URLRequest(url: url))
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            print(result as! String)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // This space can be left blank
    }
}

struct WebRepresent: View {
    
    var url: URL
    var body: some View{
        VStack{
            WebView(url: url)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear{print("\(url)")}
        
    }
}
