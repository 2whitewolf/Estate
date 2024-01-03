//
//  class LoginViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 11.10.2023.
//

import Foundation
import Combine
import KeychainSwift

class LoginViewModel: ObservableObject {

    @Published var state: Login = .login
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var user: User?
    @Published var emailToChange: String = ""
    
    @Published var showingSheet: Bool = false
    @Published var loginProviderUrl: URL? 
    
    
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    let keychain = KeychainSwift()
    
    init(){
        
    }
   
    func login() {
        networking.login(email: email, password: password)
//            .sink {[weak self] completion in
//                            guard let self = self else { return }
//                            switch completion {
//                            case .failure(let error):
//                                print(error)
//                            case .finished:
//                                break
//                            }
//                        } receiveValue: {[weak self] value in
//                            guard let self = self else { return }
//                            self.user = value.user
//                            keychain.set(value.token, forKey: "userToken")
//                            
//                        }
//            .store(in: &subscriptions)

    }

    func loginWithApple() {
      loginProviderUrl =   networking.login_withProvider(provider: .Apple)
        showingSheet.toggle()

    }
    
    func loginWithGoogle() {
        loginProviderUrl =   networking.login_withProvider(provider: .Google)
        showingSheet.toggle()
    }
    
    
    func forgetPassword(){
        networking.forgotPassword(email: email)
            .sink {[weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: {[weak self] value in
                guard let self = self else { return }
                state = state.next()
            }
            .store(in: &subscriptions)
    }
    
    func changePassword(code:String, password: String) {
        networking.changePassword(code: code, password: password)
            .sink {[weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: {[weak self] value in
                guard let self = self else { return }
                state = .login
            }
            .store(in: &subscriptions)
    }
  
}


enum Login: CaseIterable {
    case login, forgotPassword, sended, changePassword
}
