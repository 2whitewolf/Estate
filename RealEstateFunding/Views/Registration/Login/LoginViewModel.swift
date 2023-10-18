//
//  class LoginViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 11.10.2023.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var user: UserData?
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    
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
                        }
            .store(in: &subscriptions)

    }
    func login_with_Google() {
        networking.login_withProvider(provider: .Google)
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
//                            self.user = value
                        }
            .store(in: &subscriptions)

    }
    
    func login_with_Apple(){
        
    }


    
    func forgetPassword(){
        
    }
  
}

