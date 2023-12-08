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
    case updateUser
    case forget_password
    case change_password
    case login_provider
    case getAllProperties
    case getById
    case getInvoice
     case getPortfolio
     case getInvestmentDetail
     case addFunds
     case getWalletTransactions
     case getCostOfInvestment
     case addToFavourite
     case getFavouriteProperties
     case deletePropertyFromFavourites
    
    

    var baseURL: String {
        return "https://afehe-hwf.buzz/api"
    }

    var path: String {
        switch self {
            //MARK: Login\Registration
        case .login:
            return "/login"
        case .register:
            return  "/register"
        case .updateUser:
            return  "/update"
        case .forget_password:
            return  "/forgotPassword"
        case .change_password:
            return "/changePassword"
        case .login_provider:
            return "/login"
            //MARK: Properties
        case .getAllProperties:
            return "/client/property/getAll"
        case .getById:
            return "/client/property/getOne"
        case .addToFavourite:
            return "/client/favorite/add"
        case.getFavouriteProperties:
            return "/client/favorite/getAll"
        case .deletePropertyFromFavourites:
            return "/client/favorite/delete"
        case .getPortfolio:
            return "/client/portfolio/getAll"
            
            //MARK: INVEST
        case .getInvoice:
            return "/client/payment/createInvoice"
        case .getInvestmentDetail:
            return "/client/portfolio/getOne"
        case .addFunds:
            return "/client/wallet/addFunds"
        case .getWalletTransactions:
            return "/client/wallet/getAll"
        case .getCostOfInvestment:
            return "/client/payment/countInvestments"
      
        }
    }
    var method: HTTPMethod {
        switch self {
        case .login, .register, .updateUser, .change_password, .forget_password, .login_provider, .addToFavourite:
            return .post
        case .getAllProperties, .getFavouriteProperties, .getById, .getInvoice, .getPortfolio, .getInvestmentDetail, .addFunds, .getWalletTransactions, .getCostOfInvestment:
            return .get
        case .deletePropertyFromFavourites:
            return .delete
        }
    }
    
}
