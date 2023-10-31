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
    @Published var registrationCompleted: Bool = false
    @Published var user: User?
    @Published var userToken: String = ""
    let keychain = KeychainSwift()
    
    init(){
        userToken = keychain.get("userToken") ?? ""
        if presented {
            currentState = .appStart
        } else if !userToken.isEmpty {
            currentState = .app
        }
    }
    func login() {
    }
    
    
    func register(){
        
    }
    
    func forgetPassword(){
        
    }
    func newPassword(){
        
    }
}
enum AppState {
    case onboarding,appStart, login, registration, app
}
