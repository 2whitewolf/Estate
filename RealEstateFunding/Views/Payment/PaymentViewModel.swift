//
//  PaymentViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 14.12.2023.
//

import Foundation
import SwiftUI
import Combine
import StripePaymentSheet
import Alamofire


class PaymentViewModel: ObservableObject {
    @Published var paymentSheet: PaymentSheet?
    @Published var invetsmentsCost: PaymentAdditionals?
    @Published var paymentData: PaymentDataClass?
    @Published var walletBalance: WalletDataClass?
    @Published var paymentResult: PaymentSheetResult?
    @Published var showSuccesView: Bool = false
    @Published var paymentMethod: PaymentMethod = .stripe
    @Published var paymentCase: PaymentCase = .investition
    
    @Published var invest: Int = 500

    
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    
    var appViewModel: AppViewModel?{
        didSet{
            if let user = appViewModel?.user {
                self.userID = user.id
            }
        }
    }
    var propertyDetail: PropertyDetail?
    
    var userID: Int = 0
    
    
    init() {
        
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
    
    func configureStripe (payment: PaymentDataClass) {

        STPAPIClient.shared.publishableKey = payment.publishableKey
        var configuration = PaymentSheet.Configuration()
//        configuration.applePa
        configuration.merchantDisplayName = "iOS Sample, Inc."
        configuration.allowsDelayedPaymentMethods = true
               DispatchQueue.main.async {
                   self.paymentSheet = PaymentSheet(paymentIntentClientSecret: payment.clientSecret ?? "", configuration: configuration)
               }
    }
    
    func onPaymentCompletion(result: PaymentSheetResult) {
      self.paymentResult = result
        print(result)
        switch result {
        case .completed:
            DispatchQueue.main.async {[weak self] in
                self?.showSuccesView.toggle()
            }
        case .canceled:
            print("")
        case .failed(let error):
            print(error.localizedDescription)
        }

    }
    
    func canPayWithWallet() -> Bool {
            guard let walletBalance = walletBalance?.balance  else { return false }
            guard let transactionCosts = invetsmentsCost?.transactionCosts else { return false}
            
            return walletBalance > transactionCosts
    }
    
    func createInvoice() {
            
            if let propertyDetail = propertyDetail, let investmentCost = invetsmentsCost {
                
                networking.createInvoice(userId: self.userID, propertyId: propertyDetail.id ?? 0, amount: Double(invest), transactionCosts: investmentCost.transactionCosts ?? 0, dubxFee: investmentCost.dubxFee ?? 0, dldFee: investmentCost.dldFee ?? 0, registrationFee: investmentCost.registrationFee ?? 0, investmentCost: investmentCost.investmentCost ?? 0)
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
                        print("invoice \(value)")
                        if let payment = value.data {
                            self.paymentData = payment
                            print(payment)
                            
                            configureStripe(payment: payment)
                        }
                        
                    }
                    .store(in: &subscriptions)
            }
    }
    
    func getTransactionsCosts( amount: Double) {
        
        if let propertyDetail = propertyDetail {
            networking.getInvestmentCost(userId: self.userID, propertyId: propertyDetail.id ?? 1, amount: Double(self.invest))
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
    func goBack(){
        if let appViewModel = appViewModel {
            appViewModel.selectedTab = .portfolio
        }
    }
}


enum PaymentCase{
    case investition, doubleInvestition, addFunds
}

//protocol Payment {
//    var invest: Double { get set }
//    func getWalletBalance()
//    func getTransactionsCosts( amount: Double)
//    func createInvoice(amount: Double)
//    func canPayWithWallet() -> Bool
//    func onPaymentCompletion(result: PaymentSheetResult)
//    func configureStripe (payment: PaymentDataClass)
//}

