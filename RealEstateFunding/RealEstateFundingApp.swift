//
//  RealEstateFundingApp.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI

@main
struct RealEstateFundingApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                 AppMainState()
            }
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            .navigationViewStyle(StackNavigationViewStyle())
        }
      
    }
}
