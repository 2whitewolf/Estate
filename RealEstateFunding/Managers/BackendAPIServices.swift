//
//  BackendAPIServices.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 11.10.2023.
//

import Foundation
 import Alamofire
enum BackendAPIService {
    case login
    case register
    case forget_password
    case change_password
    case login_provider
     case getAll
    case getById
    var baseURL: String {
      return "https://afehe-hwf.buzz/api"
    }
//    var baseUrl : URL{
//        return URL(string:"https://afehe-hwf.buzz/api")!
//    }
    var path: String {
        switch self {
       
        case .login:
            return "/login"
        case .register:
          return  "/password"
        case .forget_password:
          return  "/forgotPassword"
        case .change_password:
            return "/changePassword"
        case .login_provider:
            return "/login"
        case .getAll:
            return "/client/property/getAll"

        case .getById:
            return "/client/property/getOne"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .login, .register, .change_password, .forget_password, .login_provider:
            return .post
        case .getAll, .getById:
            return .get
        }
    }
    
    var headers: String {
        ""
    }
    
    var parameters: String {
        ""
    }
    
}
