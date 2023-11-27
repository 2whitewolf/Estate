//
//  APIManager.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 05.10.2023.
//

import Foundation
import Alamofire
import Combine
import KeychainSwift

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
     //MARK: Login and User data
    func login(email: String, password: String) -> AnyPublisher<UserData, AFError>
    func register(email: String, password: String) -> AnyPublisher<UserData, AFError>
    func updateUser(name: String?, birth: String?, phone: String?, citizenship: String?, country: String?, city: String?, address: String?, employment: String?, organization: String?, org_role: String?, working_period: String?, industry: String?, income: String?, net_worth: String?)
    func changePassword(code: String, password:String) -> AnyPublisher<String,AFError>
    func forgotPassword(email: String) -> AnyPublisher<String,AFError>
    func login_withProvider(provider: Provider) -> URL
    
    // MARK: Properties
    func getAll() -> AnyPublisher<PropertyData, AFError>
    func getPropertyById(id: Int ) -> AnyPublisher<PropertyDetailData,AFError>
    func createInvoice(userId: Int, propertyId: Int, amount: Double) -> AnyPublisher<Payment,AFError>
    
    // MARK: Portfolio
    func getPortfolio(userId: Int) -> AnyPublisher<InvestmentsData,AFError>
    func getInvestmentDetail(userId: Int, propertyId: Int) -> AnyPublisher<InvestmentDetailData,AFError>
    func getWalletTransactions(userId: Int) -> AnyPublisher<AccountInfo,AFError>
    
    func getInvestmentCost(userId: Int, propertyId: Int, amount: Double)
}


class APIManager: APIProtocol{

    
 
    let keychain = KeychainSwift()
    func addFunds(userId: Int, amount: Double) {
        
        let url = makeUrl(make: .addFunds)
        
        let method = BackendAPIService.addFunds.method
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(userId)",
            "amount" : "\(amount)"
        ]
        print(url)
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .responseDecodable(of: PaymentAdditionals.self) {[weak self] response in
                guard let self = self else {return}
                
                switch response.result {
                case .success(_):
                    let data = try? self.newJSONDecoder().decode(PaymentAdditionals.self, from: response.data!)
                    guard let data = data else {return}
                    print(data)
                case .failure(let error):
                    print("Erorr: \(error)")
                }
            }
        
        //            .validate()
        //            .publishDecodable(type: AccountInfo.self)
        //            .value()
        //            .receive(on: DispatchQueue.main)
        //            .eraseToAnyPublisher()
    }
    
    func getInvestmentCost(userId: Int, propertyId: Int, amount: Double) {
        
        let url = makeUrl(make: .getCostOfInvestment)
        
        let method = BackendAPIService.getCostOfInvestment.method
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(userId)",
            "property_id" : "\(propertyId)" ,
            "amount" : "\(amount)"
        ]
        print(url)
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .responseDecodable(of: PaymentAdditionals.self) {[weak self] response in
                guard let self = self else {return}
                
                switch response.result {
                case .success(_):
                    let data = try? self.newJSONDecoder().decode(PaymentAdditionals.self, from: response.data!)
                    guard let data = data else {return}
                    print(data)
                case .failure(let error):
                    print("Erorr: \(error)")
                }
            }
        
        //            .validate()
        //            .publishDecodable(type: AccountInfo.self)
        //            .value()
        //            .receive(on: DispatchQueue.main)
        //            .eraseToAnyPublisher()
    }
    
    func getWalletTransactions(userId: Int)  -> AnyPublisher<AccountInfo,AFError> {
        let url = makeUrl(make: .getWalletTransactions)
        
        let method = BackendAPIService.getWalletTransactions.method
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(userId)"
        ]
        print(url)
      return  AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: AccountInfo.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getInvestmentDetail(userId: Int, propertyId: Int) -> AnyPublisher<InvestmentDetailData,AFError> {
        let url = makeUrl(make: .getInvestmentDetail)
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        let parameters: [String: String] = [
            "user_id":"\(userId)",
            "property_id":"\(propertyId)"
            
        ]
        let method = BackendAPIService.getInvestmentDetail.method
        
       return AF.request(url, method: method, parameters: parameters, headers: headers)
//            .responseDecodable(of: InvestmentDetailData.self) {[weak self] response in
//                           guard let self = self else {return}
//           
//                           switch response.result {
//                           case .success(_):
//                               let data = try? self.newJSONDecoder().decode(InvestmentDetailData.self, from: response.data!)
//                               guard let data = data else {return}
//                               print(data)
//                           case .failure(let error):
//                               print("Erorr: \(error)")
//                           }
//                       }
            .validate()
            .publishDecodable(type: InvestmentDetailData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    func getPortfolio(userId: Int) -> AnyPublisher<InvestmentsData,AFError> {
        let url = makeUrl(make: .getPortfolio)
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
               .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(userId)"
        ]
        let method = BackendAPIService.getPortfolio.method
        
       return AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: InvestmentsData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func updateUser(name: String?, birth: String?, phone: String?, citizenship: String?, country: String?, city: String?, address: String?, employment: String?, organization: String?, org_role: String?, working_period: String?, industry: String?, income: String?, net_worth: String?) {
        let url = makeUrl(make: .updateUser)
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
               .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = ["name": name ?? "",
                                            "birth": birth ?? "",
                                            "phone":  phone ?? "",
                                            "citizenship": citizenship ?? "",
                                            "country": country ?? "",
                                            "city": city ?? "",
                                            "address": address ?? "",
                                            "employment": employment ?? "",
                                            "organization": organization ?? "",
                                            "org_role": org_role ?? "",
                                            "working_period": working_period ?? "",
                                            "industry": industry ?? "",
                                            "income": income ?? "",
                                            "net_worth":net_worth ?? ""
        ]
        let method = BackendAPIService.updateUser.method
        
        AF.request(url, method: method, parameters: parameters, headers: headers)
    }
    
    func newJSONDecoder() -> JSONDecoder {
            let decoder = JSONDecoder()
            if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
                decoder.dateDecodingStrategy = .iso8601
            }
            return decoder
        }
    
    func createInvoice(userId: Int, propertyId: Int, amount: Double) -> AnyPublisher<Payment,AFError> {
        let url = makeUrl(make: .getInvoice)
        
        let method = BackendAPIService.getInvoice.method
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
               .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(userId)",
            "property_id": "\(propertyId)",
            "amount" : "\(amount)",
            "transactionCosts" : "",
            "dubxFee":"",
            "dldFee": "",
            "registrationFee" : "",
            "investmentCost" : ""
]
    
     return AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: Payment.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    
        
//        print("url:\(url)\n method: \(method) \n parameters: \(parameters) \n headers \(headers)")
//        AF.request(url,method: method,parameters: parameters,headers: headers)
//            .responseDecodable(of: Payment.self) {[weak self] response in
//                guard let self = self else {return}
//                
//                switch response.result {
//                case .success(_):
//                    let data = try? self.newJSONDecoder().decode(Payment.self, from: response.data!)
//                    guard let data = data else {return}
//                    print(data)
//                case .failure(let error):
//                    print("Erorr: \(error)")
//                }
//            }

       
    }
    
    func getPropertyById(id: Int ) -> AnyPublisher<PropertyDetailData,AFError> {
        let url = makeUrl(make: .getById)
        
        let method = BackendAPIService.getById.method
        
        let token = keychain.get("userToken") ?? ""
        
        let headers: HTTPHeaders = [
               .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = ["id": "\(id)"]
    
        return  AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: PropertyDetailData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getAll() -> AnyPublisher<PropertyData, Alamofire.AFError> {
        let url = makeUrl(make: .getAll)
        
        let method = BackendAPIService.getAll.method
        
        let token = keychain.get("userToken") ?? ""
        
        let headers: HTTPHeaders = [
               .authorization(bearerToken: token)]
        return  AF.request(url,method: method, headers: headers)
            .validate()
            .publishDecodable(type: PropertyData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
//      AF.request(url,method: method, headers: headers)
//                 .responseDecodable(of: PropertyData.self ) { response in
//                     switch response.result {
//                                 case .success(_):
//                                     let data = try? self.newJSONDecoder().decode(PropertyData.self, from: response.data!)
//                                     guard let data = data else {return}
//                         print(data)
//     //                                completion(data,nil)
//                                 case .failure(let error):
//     //                                completion(nil, error)
//                                     print("Erorr: \(error)")
//                                 }
//     
//     
//                 }
    }
    
    func login_withProvider(provider: Provider) -> URL {
        let url = makeUrl(make: .login_provider)
        let method = BackendAPIService.login_provider.method
        
        let newPathComponent = "/\(provider.path)"
        let updatedURL = url.appendingPathComponent(newPathComponent)
         return updatedURL
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
        let parameters: [String: String] = [
                                            "email": email,
                                            "password": password,
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
        return URL(string: make.baseURL + make.path)!
    }
}
