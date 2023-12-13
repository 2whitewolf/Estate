//
//  PropertiesViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.10.2023.
//

import Foundation
import SwiftUI
import Combine
import StripePaymentSheet
import Alamofire

enum PropertiesListEnum: String, CaseIterable{
    case available, funded
}

class PropertiesViewModel: ObservableObject {
    @Published var invetsmentsCost: PaymentAdditionals?
    @Published var properties: [Property] = []
    @Published var propertyDetail: PropertyDetail?
    @Published var similar: [Property]?
    @Published var selectedList:PropertiesListEnum = .available {
        didSet{
           getAllProperties()
        }
    }
    @Published var paymentData: PaymentDataClass?
    @Published var walletBalance: WalletDataClass?
    
    
    @Published var propertyPreviewHistory: [Int] = []
//    @Published var linkToPayment: URL?
//    @Published var openWebViewToPay: Bool = false
    @Published var paymentMethod: PaymentMethod = .stripe
    @Published var fcmRegTokenMessage:String = ""

    
    var userID: Int = 0
    
   @Published var user: User? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                if let user = self?.user {
                    self?.userID = user.id
                }
            }
        }
    }
    
    
    
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    

    deinit {
       
        subscriptions.removeAll()
    }
    
 
    
    func getDataOnMain() {
        getAllProperties()
      
        paymentMethod = .stripe
    }
    
    func getAllProperties() {
        
      getResponseAboutProperties()
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
                    self.properties = value.data
                }
                .store(in: &subscriptions)
    }
    
    func getResponseAboutProperties() -> AnyPublisher<PropertyData, AFError>{
     return    switch selectedList{
        case .available:
              networking.getAll(id: userID)
        case .funded:
             networking.getFundedProperties(userId: userID)
        }
    }
    
    func getWalletBalance() {
        networking.getWalletBalance(userId: self.userID)
            .sink {[weak self] completion in
                            guard let self = self else { return }
                            switch completion {
                            case .failure(let error):
                                print(error.localizedDescription)
                            case .finished:
                                break
                            }
                        } receiveValue: {[weak self] value in
                            guard let self = self else { return }
                            if let data = value.data {
                                self.walletBalance = data
                            }
                            
                            
                        }
            .store(in: &subscriptions)
    }
    
    func getPropertyDetail(id: Int){
        networking.getPropertyById(id: id)
            .sink {[weak self] completion in
                            guard let self = self else { return }
                            switch completion {
                            case .failure(let error):
                                print(error.localizedDescription)
                            case .finished:
                                break
                            }
                        } receiveValue: {[weak self] value in
                            guard let self = self else { return }
                            if let data = value.data {
                                self.propertyDetail = data.property
                                self.similar = data.similar
                            }
                        }
            .store(in: &subscriptions)
    }
    
    func createInvoice(amount: Double) {
       
        if let propertyDetail = propertyDetail, let investmentCost = invetsmentsCost {
           
           // networking.createInvoice(userId: self.userID, propertyId: propertyDetail.id ?? 1, amount: amount)
            networking.createInvoice(userId: self.userID, propertyId: propertyDetail.id ?? 0, amount: amount, transactionCosts: investmentCost.transactionCosts ?? 0, dubxFee: investmentCost.dubxFee ?? 0, dldFee: investmentCost.dldFee ?? 0, registrationFee: investmentCost.registrationFee ?? 0, investmentCost: investmentCost.investmentCost ?? 0)
                .sink {[weak self] completion in
                                guard let self = self else { return }
                                switch completion {
                                case .failure(let error):
                                    print(error.localizedDescription)
                                case .finished:
                                    break
                                }
                            } receiveValue: {[weak self] value in
                                guard let self = self else { return }
                                self.paymentData = value.data
                                print(value.data)
                            }
                .store(in: &subscriptions)
        }
      
    }
    
    func getTransactionsCosts( amount: Double) {
        
        if let propertyDetail = propertyDetail {
            networking.getInvestmentCost(userId: self.userID, propertyId: propertyDetail.id ?? 1, amount: amount)
                .sink {[weak self] completion in
                                guard let self = self else { return }
                                switch completion {
                                case .failure(let error):
                                    print(error.localizedDescription)
                                case .finished:
                                    break
                                }
                            } receiveValue: {[weak self] value in
                                guard let self = self else { return }
                                print(value.data)
                                invetsmentsCost = value.data
                            }
                .store(in: &subscriptions)
        }
                
    }
    
    func addPropertyToFavourites(propertyId: Int){
        networking.addToFavourite(userId: self.userID, propertyId: propertyId)
        getAllProperties()
    }
    
    func canPayWithWallet() -> Bool {
            guard let walletBalance = walletBalance?.balance  else { return false }
            guard let transactionCosts = invetsmentsCost?.transactionCosts else { return false}
            
            return walletBalance > transactionCosts
    }
    
    func deletePropertyFromFavourites(propertyId: Int){
        networking.deletePropertyFromFavourites(userId: self.userID, propertyId: propertyId)
//        withAnimation{
//                properties.removeAll(where: {$0.id == propertyId})
//        }
    }
    
    func getFavouriteProperties() {
        networking.getFavouriteProperties(userId: self.userID)
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
                           
                            self.properties = value.data.map{
                                Property(id: $0.id,
                                         totalPrice: $0.totalPrice,
                                         annualProfit: $0.annualProfit,
                                         period: $0.period,
                                         location: $0.location,
                                         bed: $0.bed,
                                         meter: $0.meter,
                                         type: $0.type,
                                         favorite: true,
                                         invested: $0.invested,
                                         investors: $0.investors,
                                         funded: $0.funded,
                                         images: $0.images
                                )
                            }
                        }
            .store(in: &subscriptions)
        
        
    }
}
enum PaymentMethod {
    case stripe,wallet,apple,crypto
    
    var image: String? {
        switch self {
        case .stripe:
            "stripe_icon"
        case .wallet:
            nil
        case .apple:
            "apple_pay_icon"
        case .crypto:
            "crypto_icon"
        }
    }
}
