//
//  AppViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 11.10.2023.
//

import Foundation
import KeychainSwift
import SwiftUI

class AppViewModel: ObservableObject {
    @AppStorage("onBoarding") var presented: Bool = false
    @Published var currentState: AppState = .onboarding {
        didSet {
            if  currentState == .appStart && !presented {
                presented = true
            }
        }
    }
    
    @Published var user: User? {
        didSet{
            userDefaults.user = user
        }
    }
    
    @Published var userToken: String = ""
    
    
    var userDefaults = UserDefaultsManager.shared
    let keychain = KeychainSwift()
    
    
    
    init(){
      user = userDefaults.user
        userToken = keychain.get("userToken") ?? ""
        if presented {
            currentState = .appStart
        }
        if !userToken.isEmpty {
            currentState = .app
        }
    }
    
    func logout(){
        withAnimation{
            currentState = .login
        }
         user = nil
        keychain.set("", forKey: "userToken")
    }
    
    func deleteAccount(){
        
    }
}
enum AppState {
    case onboarding,appStart, login, registration, app
}
