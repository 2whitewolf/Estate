//
//  PropertiesViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.10.2023.
//

import Foundation
import SwiftUI
import Combine

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
    
    @Published var propertyPreviewHistory: [Int] = []
    @Published var linkToPayment: URL?
    @Published var openWebViewToPay: Bool = false
    
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    
    func getAllProperties() {
        networking.getAll()
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
    
    func createInvoice(userId:Int, amount: Double) {
       
        if let propertyDetail = propertyDetail {
           
            networking.createInvoice(userId: userId, propertyId: propertyDetail.id ?? 1, amount: amount)
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
    
    func getTransactionsCosts(userId:Int, amount: Double) {
        
        if let propertyDetail = propertyDetail {
            networking.getInvestmentCost(userId: userId, propertyId: propertyDetail.id ?? 1, amount: amount)
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
                                print(value)
                                invetsmentsCost = value
                            }
                .store(in: &subscriptions)
        }
                
    }
}
