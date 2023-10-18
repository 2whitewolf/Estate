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
     
//    @Published var properties: [Property] = []
//    
//    private var subscriptions: Set<AnyCancellable> = []
//    private let networking: APIProtocol = APIManager()
//    
//    func getAllProperties() {
//        networking.getAll()
//            .sink {[weak self] completion in
//                            guard let self = self else { return }
//                            switch completion {
//                            case .failure(let error):
//                                print(error)
//                            case .finished:
//                                break
//                            }
//                        } receiveValue: {[weak self] value in
//                            guard let self = self else { return }
//                            print(value)
//                            self.properties = value.data
//                        }
//            .store(in: &subscriptions)
//    }
}
