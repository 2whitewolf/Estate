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
    
    @Published var properties: [Property] = []
    @Published var favoriteProperties: [Property] = []
    @Published var propertyDetail: PropertyDetail?
    @Published var similar: [Property]?
    @Published var selectedList:PropertiesListEnum = .available {
        didSet{
           getAllProperties()
        }
    }
  
    
    
    @Published var propertyPreviewHistory: [Property] = []
    @Published var fcmRegTokenMessage:String = ""
    @Published var isLoading: Bool = false
    
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
    
    
    init(){
        print("initial")
    }
 
    @MainActor
    func getDataOnMain() {
        getAllProperties()
    }
    
    
    func favoriteButtonPressed(property:  Property) {
        if let favorite = property.favorite {
            if favorite {
                deletePropertyFromFavourites(property: property)
            } else {
                addPropertyToFavourites( property: property)
            }
        }
    }
    
    func getAllProperties() {
        isLoading = true
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
                    isLoading = false
                }
                .store(in: &subscriptions)
    }
    
    func getResponseAboutProperties() -> AnyPublisher<PropertyData, AFError>{
     return  switch selectedList{
        case .available:
              networking.getAll(id: userID)
        case .funded:
             networking.getFundedProperties(userId: userID)
        }
    }
    
    func getPropertyDetail(property: Property){
        isLoading = true
        if propertyPreviewHistory.isEmpty{
            propertyPreviewHistory.append(property)
            
        }
        if let id = property.id{
            networking.getPropertyById(id:id)
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
                        self.isLoading = false
                    }
                }
                .store(in: &subscriptions)
        }
    }
    
    func addPropertyToFavourites(property: Property){
        if let id = property.id {
            networking.addToFavourite(userId: self.userID, propertyId: id)
            getAllProperties()
        }
    }
    
    func deletePropertyFromFavourites(property: Property){
        if let id = property.id {
            networking.deletePropertyFromFavourites(userId: self.userID, propertyId: id)
            withAnimation{
                favoriteProperties.removeAll(where: {$0.id == id})
            }
        }
    }
    
    func getFavouriteProperties() {
        isLoading = true
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
                            isLoading = false
                        }
            .store(in: &subscriptions)
        
        
    }
    
    func createPaymentViewModel() -> PaymentViewModel {
         let viewModel = PaymentViewModel()
        viewModel.propertyDetail = self.propertyDetail
        viewModel.appViewModel = self.appViewModel
        return viewModel
    }
    
    func backButtonTapped() -> Bool {
        if propertyPreviewHistory.count <= 1 {
            propertyDetail = nil
             return true
        } //else {
            backToPreviously()
        return false
        
    }
    
    func addPropertyToHistory(property: Property){
        propertyPreviewHistory.append(property)
        getPropertyDetail(property: property)
    }
    
    func backToPreviously() {
        propertyPreviewHistory.removeLast()
        if let last = propertyPreviewHistory.last {
            getPropertyDetail(property: last)
        }
    }
    
}

