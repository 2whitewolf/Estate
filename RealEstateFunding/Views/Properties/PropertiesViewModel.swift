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
   

    
    
    @Published var paymentSheet: PaymentSheet?
    @Published var invetsmentsCost: PaymentAdditionals?
    @Published var paymentData: PaymentDataClass?
    @Published var walletBalance: WalletDataClass?
    @Published var paymentResult: PaymentSheetResult?
    @Published var showSuccesView: Bool = false
//    @Published var paymentIntentParams: STPPaymentIntentParams?

    
    
    @Published var properties: [Property] = []
    @Published var favoriteProperties: [Property] = []
    @Published var propertyDetail: PropertyDetail?
    @Published var similar: [Property]?
    @Published var selectedList:PropertiesListEnum = .available {
        didSet{
           getAllProperties()
        }
    }
  
    
    
    @Published var propertyPreviewHistory: [Int] = []
    @Published var fcmRegTokenMessage:String = ""

    
   private var userID: Int = 0
    
   @Published var appViewModel: AppViewModel? {
        didSet{
                if let user = self.appViewModel?.user {
                    self.userID = user.id
                }
        }
    }
    
    
    
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    

    deinit {
       
        subscriptions.removeAll()
    }
    
 
    @MainActor
    func getDataOnMain() {
        getAllProperties()
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
    
//    func getWalletBalance() {
//        networking.getWalletBalance(userId: self.userID)
//            .sink {[weak self] completion in
//                            guard let self = self else { return }
//                            switch completion {
//                            case .failure(let error):
//                                print(error.localizedDescription)
//                            case .finished:
//                                break
//                            }
//                        } receiveValue: {[weak self] value in
//                            guard let self = self else { return }
//                            if let data = value.data {
//                                self.walletBalance = data
//                            }
//                            
//                            
//                        }
//            .store(in: &subscriptions)
//    }
//    
//   
    
//    func createInvoice(amount: Double) {
//       
//        if let propertyDetail = propertyDetail, let investmentCost = invetsmentsCost {
//           
//           // networking.createInvoice(userId: self.userID, propertyId: propertyDetail.id ?? 1, amount: amount)
//            networking.createInvoice(userId: self.userID, propertyId: propertyDetail.id ?? 0, amount: amount, transactionCosts: investmentCost.transactionCosts ?? 0, dubxFee: investmentCost.dubxFee ?? 0, dldFee: investmentCost.dldFee ?? 0, registrationFee: investmentCost.registrationFee ?? 0, investmentCost: investmentCost.investmentCost ?? 0)
//                .sink {[weak self] completion in
//                                guard let self = self else { return }
//                                switch completion {
//                                case .failure(let error):
//                                    print(error.localizedDescription)
//                                case .finished:
//                                    break
//                                }
//                            } receiveValue: {[weak self] value in
//                                guard let self = self else { return }
//                               print("invoice \(value)")
//                                if let payment = value.data {
//                                    self.paymentData = payment
//                                    print(payment)
//                                   
//                                    configureStripe(payment: payment)
//                                }
//                               
//                            }
//                .store(in: &subscriptions)
//        }
//      
//    }
    
//    func getTransactionsCosts( amount: Double) {
//        
//        if let propertyDetail = propertyDetail {
//            networking.getInvestmentCost(userId: self.userID, propertyId: propertyDetail.id ?? 1, amount: amount)
//                .sink {[weak self] completion in
//                                guard let self = self else { return }
//                                switch completion {
//                                case .failure(let error):
//                                    print(error.localizedDescription)
//                                case .finished:
//                                    break
//                                }
//                            } receiveValue: {[weak self] value in
//                                guard let self = self else { return }
//                                print(value.data)
//                                invetsmentsCost = value.data
//                            }
//                .store(in: &subscriptions)
//        }
//                
//    }
    
   
    
//    func canPayWithWallet() -> Bool {
//            guard let walletBalance = walletBalance?.balance  else { return false }
//            guard let transactionCosts = invetsmentsCost?.transactionCosts else { return false}
//            
//            return walletBalance > transactionCosts
//    }
//    
//    func configureStripe (payment: PaymentDataClass) {
//          STPAPIClient.shared.publishableKey = payment.publishableKey
//          var configuration = PaymentSheet.Configuration()
//          configuration.merchantDisplayName = "iOS Sample, Inc."
//          configuration.allowsDelayedPaymentMethods = true
//                 DispatchQueue.main.async {
//                     self.paymentSheet = PaymentSheet(paymentIntentClientSecret: payment.clientSecret ?? "", configuration: configuration)
//                 }
//      }
//      
      
      
//      func onPaymentCompletion(result: PaymentSheetResult) {
//        self.paymentResult = result
//          print(result)
//          switch result {
//          case .completed:
//              DispatchQueue.main.async {[weak self] in
//                  self?.showSuccesView.toggle()
//              }
//          case .canceled:
//              print("")
//          case .failed(let error):
//              print(error.localizedDescription)
//          }
//  
//      }
//    
    func addPropertyToFavourites(propertyId: Int){
        networking.addToFavourite(userId: self.userID, propertyId: propertyId)
        getAllProperties()
    }
    
    func deletePropertyFromFavourites(propertyId: Int){
        networking.deletePropertyFromFavourites(userId: self.userID, propertyId: propertyId)
        withAnimation{
          favoriteProperties.removeAll(where: {$0.id == propertyId})
        }
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
                           
                            self.favoriteProperties = value.data.map{
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
    
    func createPaymentViewModel() -> PaymentViewModel {
         let viewModel = PaymentViewModel()
        viewModel.propertyDetail = self.propertyDetail
        viewModel.appViewModel = self.appViewModel
        return viewModel
    }
    
    func cleanVMAfterPayment(){
        self.paymentSheet = nil
        self.invetsmentsCost = nil
        self.paymentData = nil
        self.walletBalance = nil
        self.paymentResult =  nil
        self.showSuccesView = false
    }
    
    
}
enum PaymentMethod {
    case stripe,wallet,apple,crypto
    var name: String{
        switch self {
        case .stripe:
            "Stripe"
        case .wallet:
            "Wallet"
        case .apple:
            "Apple pay"
        case .crypto:
            "Crypto"
        }
    }
    
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


//extension PaymentSheetResult:Equatable{
//    public static func == (lhs: StripePaymentSheet.PaymentSheetResult, rhs: StripePaymentSheet.PaymentSheetResult) -> Bool {
//        switch (lhs, rhs) {
//        case (.completed, .completed):
//                // Compare relevant properties of completed cases
//                return lhs == rhs
//            case (.canceled, .canceled):
//                // Both are canceled, consider them equal
//                return true
//            default:
//                // Other cases are not equal
//                return false
//            }
//    }
//}
