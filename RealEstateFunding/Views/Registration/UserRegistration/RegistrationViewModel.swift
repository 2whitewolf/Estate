//
//  RegistrationViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 05.10.2023.
//

import Foundation
class RegistrationViewModel: ObservableObject {
    @Published var currentState: RegistrationStates = .signUp
    @Published var registrationCompleted: Bool = false
    init(){
        
    }
    func getScan(text: String?) {
        if let current = text {
            current.map{ "shgg\($0)" }
        }
    }
    func login() {
//        AP
    }
    
    
    func register(){
        
    }
    
    func forgetPassword(){
        
    }
    func newPassword(){
        
    }
}




enum RegistrationStates{
    case signUp,inputData, selectCountry, from,terms, investorTerms
}
