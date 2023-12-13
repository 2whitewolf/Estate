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
    func getAll(id:Int) -> AnyPublisher<PropertyData, AFError>
    func getFundedProperties(userId: Int ) -> AnyPublisher< PropertyData,AFError>
    func getPropertyById(id: Int ) -> AnyPublisher<PropertyDetailData,AFError>
    func addToFavourite(userId: Int, propertyId: Int)
    func getFavouriteProperties(userId: Int) -> AnyPublisher<PropertyData,AFError>
    func deletePropertyFromFavourites(userId: Int, propertyId:Int)
    
     // MARK: Payment && Invoices
    func createInvoice(userId: Int, propertyId: Int, amount: Double, transactionCosts: Double, dubxFee: Double, dldFee: Double, registrationFee: Double, investmentCost: Double) -> AnyPublisher<PaymentData,AFError>
    func getInvestmentCost(userId: Int, propertyId: Int, amount: Double)  -> AnyPublisher<PaymentAdditionalData,AFError>
    
    // MARK: Portfolio
    func getPortfolio(userId: Int) -> AnyPublisher<InvestmentsData,AFError>
    func getInvestmentDetail(userId: Int, propertyId: Int) -> AnyPublisher<InvestmentDetailData,AFError>
    
    //  MARK: Wallert
    func getWalletTransactions(userId: Int) -> AnyPublisher<AccountInfoData,AFError>
    func getWalletBalance(userId:Int) -> AnyPublisher<WalletData,AFError>
    
  
}


class APIManager: APIProtocol{

    let keychain = KeychainSwift()
    
    
    func deletePropertyFromFavourites(userId: Int, propertyId: Int) {
        
        let url = makeUrl(make: .deletePropertyFromFavourites)
        
        let method = BackendAPIService.deletePropertyFromFavourites.method
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(userId)",
            "property_id" : "\(propertyId)"
        ]
        
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .response{ data in
                print(data)
                
            }
    }
    
    func getFavouriteProperties(userId: Int) -> AnyPublisher<PropertyData, AFError> {
        let url = makeUrl(make: .getFavouriteProperties)
        
        let method = BackendAPIService.getFavouriteProperties.method
        
        let token = keychain.get("userToken") ?? ""
        
        let headers: HTTPHeaders = [
               .authorization(bearerToken: token)]
        
        let parameters: [String: Int] = ["user_id": userId]
        
        
        return  AF.request(url,method: method,parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: PropertyData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func addToFavourite(userId: Int, propertyId: Int) {
        
        let url = makeUrl(make: .addToFavourite)
        
        let method = BackendAPIService.addToFavourite.method
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(userId)",
            "property_id" : "\(propertyId)"
        ]
         print(url)
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .response{ data in
                print(data)
                
            }
    }
    
    func getWalletBalance(userId: Int)  -> AnyPublisher<WalletData,AFError> {
        let url = makeUrl(make: .getWalletBalance)
        
        let method = BackendAPIService.getWalletBalance.method
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(userId)",
           
        ]
      return  AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: WalletData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
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
    }
    
    func getInvestmentCost(userId: Int, propertyId: Int, amount: Double) -> AnyPublisher<PaymentAdditionalData,AFError> {
        
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
     
       return AF.request(url, method: method, parameters: parameters, headers: headers)
                    .validate()
                    .publishDecodable(type: PaymentAdditionalData.self)
                    .value()
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
    }
    
    func getWalletTransactions(userId: Int)  -> AnyPublisher<AccountInfoData,AFError> {
        let url = makeUrl(make: .getWalletTransactions)
        
        let method = BackendAPIService.getWalletTransactions.method
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        let parameters: [String: String] = [
            "user_id": "\(userId)"
        ]
      
      return  AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: AccountInfoData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
//        AF.request(url, method: method, parameters: parameters, headers: headers)
//            .responseDecodable(of: AccountInfoData.self) {[weak self] response in
//                           guard let self = self else {return}
//           
//                           switch response.result {
//                           case .success(_):
//                               let data = try? self.newJSONDecoder().decode(AccountInfoData.self, from: response.data!)
//                               guard let data = data else {return}
//                               print(data)
//                           case .failure(let error):
//                               print("Erorr: \(error)")
//                           }
//                       }
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
    
    func createInvoice(userId: Int, propertyId: Int, amount: Double, transactionCosts: Double, dubxFee: Double, dldFee: Double, registrationFee: Double, investmentCost: Double) -> AnyPublisher<PaymentData,AFError> {
        let url = makeUrl(make: .getInvoice)
        
        let method = BackendAPIService.getInvoice.method
        let token = keychain.get("userToken") ?? ""
        let headers: HTTPHeaders = [
               .authorization(bearerToken: token)
        ]
        
        let parameters: [String: Double] = [
            "user_id": Double(userId),
            "property_id": Double(propertyId),
            "amount" : amount,
            "transactionCosts" : transactionCosts,
            "dubxFee":dubxFee,
            "dldFee": dldFee,
            "registrationFee" : registrationFee,
            "investmentCost" : investmentCost,
            "fcm_id": 753243321182
        ]
    
    
     return AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: PaymentData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
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
    
    func getAll(id: Int) -> AnyPublisher<PropertyData, Alamofire.AFError> {
        let url = makeUrl(make: .getAllProperties)
        
        let method = BackendAPIService.getAllProperties.method
        
        let token = keychain.get("userToken") ?? ""
        
        let headers: HTTPHeaders = [
               .authorization(bearerToken: token)]
        
        let parameters: [String: Int] = ["user_id": id]
        
        
        return  AF.request(url,method: method,parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: PropertyData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func getFundedProperties(userId: Int) -> AnyPublisher<PropertyData,AFError> {
        let url = makeUrl(make: .getFundedProperties)
        
        let method = BackendAPIService.getFundedProperties.method
        
        let token = keychain.get("userToken") ?? ""
        
        let headers: HTTPHeaders = [
               .authorization(bearerToken: token)]
        
        let parameters: [String: Int] = ["user_id": userId]
        
        
        return  AF.request(url,method: method,parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: PropertyData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
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
