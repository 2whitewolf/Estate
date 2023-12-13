//
//  RealEstateFundingApp.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI
import Firebase
import FirebaseMessaging

@main
struct RealEstateFundingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                 AppMainState()
            }
//            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            .navigationViewStyle(StackNavigationViewStyle())
        }
      
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
    

}
