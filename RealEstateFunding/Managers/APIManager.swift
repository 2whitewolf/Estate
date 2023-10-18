//
//  APIManager.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 05.10.2023.
//

import Foundation
import Alamofire
import Combine

enum Provider{
    case Google,Apple
    var path: String {
        switch self {
        case .Google:
            return "google"
        case .Apple:
            return "apple"
        }
    }
}

protocol APIProtocol{
    func login(email: String, password: String) -> AnyPublisher<UserData, AFError>
    func register(email: String, password: String) -> AnyPublisher<UserData, AFError>
    func changePassword(code: String, password:String) -> AnyPublisher<String,AFError>
    func forgotPassword(email: String) -> AnyPublisher<String,AFError>
    func login_withProvider(provider: Provider) -> AnyPublisher<String,AFError>
     func getAll() -> AnyPublisher<PropertyData, AFError>
}


class APIManager: APIProtocol{
     let token = "104|AZiH6iKGGCb3x7hf2DUqVwyZK5MajU1r7blrlEHB44b20449"
    func getAll() -> AnyPublisher<PropertyData, Alamofire.AFError> {
        let url = makeUrl(make: .getAll)
        
        let method = BackendAPIService.getAll.method
        
        let headers: HTTPHeaders = [
               .authorization(bearerToken: token)]
        return  AF.request(url,method: method, headers: headers)
            .validate()
            .publishDecodable(type: PropertyData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func login_withProvider(provider: Provider) -> AnyPublisher<String, Alamofire.AFError> {
        let url = makeUrl(make: .login_provider)
        let method = BackendAPIService.forget_password.method
        return  AF.request(url,method: method)
            .validate()
            .publishString()
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<UserData, Alamofire.AFError> {
        let url = makeUrl(make: .login)
        let method = BackendAPIService.login.method
        let parameters: [String: String] = ["email": email, "password": password]
        return  AF.request(url,method: method,parameters: parameters)
            .validate()
            .publishDecodable(type: UserData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func register(email: String, password: String) -> AnyPublisher<UserData, Alamofire.AFError> {
        
        let url = makeUrl(make: .register)
        let method = BackendAPIService.register.method
        let parameters: [String: String] = ["name": "bogdan",
                                            "email": email,
                                            "password": password,
                                            "birth": "123456",
                                            "phone": "12454365143514",
                                            "citizenship": "gkjbvn",
                                            "country": "ff",
                                            "city": "hfgsj",
                                            "address": "djsfsjdh",
                                            "employment":"yes",
                                            "organization": "fjdfkj",
                                            "org_role":"boss",
                                            "working_period": "5",
                                            "industry":"it",
                                            "income":"40000",
                                            "net_worth":"100000"
        ]
        return  AF.request(url,method: method,parameters: parameters)
            .validate()
            .publishDecodable(type: UserData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func changePassword(code: String, password:String) -> AnyPublisher<String,AFError> {
        let url = makeUrl(make: .change_password)
        
        let method = BackendAPIService.change_password.method
        let parameters: [String: String] = [
            "code": code,
            "password": password
        ]
        return  AF.request(url,method: method,parameters: parameters)
            .validate()
            .publishString()
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func forgotPassword(email: String) -> AnyPublisher<String,AFError> {
        let url = makeUrl(make: .forget_password)
        
        let method = BackendAPIService.forget_password.method
        let parameters: [String: String] = [
            "email": email
        ]
        return  AF.request(url,method: method,parameters: parameters)
            .validate()
            .publishString()
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}


extension APIManager{
    private func makeUrl(make: BackendAPIService) -> URL{
        //        var url = URLComponents()
        //        url.scheme = "https"
        //        url.host = make.baseURL
        //        url.path = make.path
//        return URL(string: "\(make.path)", relativeTo: make.baseUrl)!
        return URL(string: make.baseURL + make.path)!
    }
}
