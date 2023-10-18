//
//  AppViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 11.10.2023.
//

import Foundation
class AppViewModel: ObservableObject {
    @Published var currentState: AppState = .app
    @Published var registrationCompleted: Bool = false
    init(){
        
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
