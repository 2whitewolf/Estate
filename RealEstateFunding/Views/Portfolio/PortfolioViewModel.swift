//
//  PortfolioViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 10.11.2023.
//

import Foundation
import SwiftUI
import Combine

class PortfolioViewModel: ObservableObject {
    @Published var investments: InvestmentDataClass?
    @Published var investmentsListOpened: Bool = false
    @Published var transactionsListOpened: Bool = false
    @Published var investmentDetail: InvestmentDetail?
    
    @Published var appViewModel: AppViewModel? {
        didSet{
                if let user = self.appViewModel?.user {
                    self.userID = user.id
                }
        }
    }
    
    
    private var userID: Int = 0
    
    var investmentsList: Binding<[Investment]> {
        Binding(get: {
            if let investments = self.investments?.investments {
                return self.investmentsListOpened ? investments : investments.enumerated().filter{ $0.offset < 4 }.map{ $0.element}
            }
            return []
        }) { (newVal) in
            
        }
    }

    
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    
    func getPortfolioData(){
        networking.getPortfolio(userId:self.userID)
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
                self.investments = value.data
                
            }
            .store(in: &subscriptions)
    }
    func getInvestmentDetailData( propertyId: Int){
        networking.getInvestmentDetail(userId: self.userID, propertyId: propertyId)
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
                self.investmentDetail = value.data
               
            }
            .store(in: &subscriptions)
    }
}
