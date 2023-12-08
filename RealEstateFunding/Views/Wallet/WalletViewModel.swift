//
//  WalletViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 24.11.2023.
//

import Foundation
import Foundation
import SwiftUI
import Combine

class WalletViewModel: ObservableObject {
    var transactionsList: Binding<[Transaction]> {
        Binding(get: {
            if let transactions = self.accountInfo?.transactions{
                return self.hidden ? transactions : transactions.enumerated().filter{ $0.offset < 4 }.map{ $0.element}
            }
            return []
        }) { (newVal) in
            
        }
    }
    
   
    @Published var accountInfo: AccountInfo?
    @Published var hidden: Bool = true
    
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    
    func getAccountInfo(userId: Int){
        networking.getWalletTransactions(userId: userId)
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
                self.accountInfo = value.data
            }
            .store(in: &subscriptions)
           
    }
   
}
