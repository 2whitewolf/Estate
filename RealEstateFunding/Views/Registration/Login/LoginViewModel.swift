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
    @Published var user: UserData?
    @Published var emailToChange: String = ""
    
    
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    let keychain = KeychainSwift()
    
    init(){
        
    }
   
    func login() {
        networking.login(email: email, password: password)
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
                            print(value)
                            self.user = value
                            keychain.set(value.token, forKey: "userToken")
                            
                        }
            .store(in: &subscriptions)

    }
    func login_with_Google() {
        networking.login_withProvider(provider: .Google)
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
//                            print(value)
//                        }
//            .store(in: &subscriptions)

    }
    
    func login_with_Apple(){
        
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
                print(value)
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
                print(value)
                state = .login
            }
            .store(in: &subscriptions)
    }
  
}


enum Login: CaseIterable {
    case login, forgotPassword, sended, changePassword
}
