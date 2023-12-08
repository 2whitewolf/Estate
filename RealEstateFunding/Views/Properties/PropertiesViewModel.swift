//
//  PropertiesViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.10.2023.
//

import Foundation
import SwiftUI
import Combine

enum PropertiesListEnum: String, CaseIterable{
    case available, funded
}

class PropertiesViewModel: ObservableObject {
    @Published var invetsmentsCost: PaymentAdditionals? 
    @Published var properties: [Property] = []
    @Published var propertyDetail: PropertyDetail? {
        didSet{
            if let  propertyDetail = propertyDetail {
                print(propertyDetail)
            }
        }
    }
    @Published var similar: [Property]?
    @Published var selectedList:PropertiesListEnum = .available
    
    @Published var propertyPreviewHistory: [Int] = []
    @Published var linkToPayment: URL?
    @Published var openWebViewToPay: Bool = false
    
    var userID: Int = 0
    
   @Published var user: User? {
        didSet{
            if let user = user {
                userID = user.id
            }
        }
    }
    
    
    
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    
    
    init( ) {
      
    }
    deinit {
       
        subscriptions.removeAll()
    }
    
 
    
    func getDataOnMain() {
        switch selectedList {
        case .available:
            getAllProperties()
        case .funded:
            print()
        }
    }
    
    func getAllProperties() {
      
            networking.getAll(id: userID)
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
                    self.properties = value.data//.enumerated().filter{ $0.offset < 3 }.map{ $0.element}
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
       
        if let propertyDetail = propertyDetail {
           
            networking.createInvoice(userId: self.userID, propertyId: propertyDetail.id ?? 1, amount: amount)
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
                                if let link = value.paymentLink {
                                    if let url  = URL(string: link) {
                                        linkToPayment = url
                                        openWebViewToPay.toggle()
                                    }
                                }
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
                             
                                invetsmentsCost = value.data
                            }
                .store(in: &subscriptions)
        }
                
    }
    
    func addPropertyToFavourites(userId:Int,propertyId: Int){
        networking.addToFavourite(userId: self.userID, propertyId: propertyId)
    }
    
    func deletePropertyFromFavourites(userId:Int,propertyId: Int){
        networking.deletePropertyFromFavourites(userId: self.userID, propertyId: propertyId)
        withAnimation{
            properties.removeAll(where: {$0.id == propertyId})
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
                           
                            self.properties = value.data//.enumerated().filter{ $0.offset < 3 }.map{ $0.element}
                        }
            .store(in: &subscriptions)
    }
}
