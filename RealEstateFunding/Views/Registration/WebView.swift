//
//  WebView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 25.10.2023.
//

import SwiftUI
import WebKit
import SwiftSoup
import KeychainSwift

struct WebView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
          Coordinator(self)
      }
    
    @Binding var user: User?
    let url: URL
    let webConfiguration = WKWebViewConfiguration()

    
    func makeUIView(context: Context) -> WKWebView {
        webConfiguration.applicationNameForUserAgent = "Version/8.0.2 Safari/600.2.5"

        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.load(URLRequest(url: url))
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            print(result as! String)
        }
        webView.evaluateJavaScript("document.documentElement.outerHTML"){ (result, error) in
           
            print("result \(result as! String)")
        }
      
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
          
          init(_ parent: WebView) {
              self.parent = parent
          }
        
        
           func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
               guard let url = navigationAction.request.url else {
                   
                   decisionHandler(.allow)
                   return
               }
             
               let urlString = url.absoluteString
               if urlString.contains("https://afehe-hwf.buzz/api/login/google/callback?") {
                   parseWebPage(url: url)
                   
               }
               decisionHandler(.allow)
           }
        
        
        func parseWebPage(url: URL) {
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let data = Data(html.utf8)
               
                parseJSON(data: data)
               
            } catch {
                print("Error: \(error)")
            }
        }
        
        func parseJSON(data: Data){
                    let decoder = JSONDecoder()
                    do {
                        let people = try decoder.decode(UserData.self, from: data)
                        parent.user = people.user
                        KeychainSwift().set(people.token, forKey: "userToken")
                    } catch {
                        print(error.localizedDescription)
                    }
        }
       
      }
}

struct WebRepresent: View {
    @Binding var user: User?
    var url: URL
    var body: some View{
        VStack{
            WebView(user: $user, url: url)
                .edgesIgnoringSafeArea(.all)
        }
    }
}




