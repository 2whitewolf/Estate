//
//  RegistrationViewModel.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 05.10.2023.
//

import Foundation
import Combine
class RegistrationViewModel: ObservableObject {
    @Published var currentState: RegistrationStates = .signUp {
        didSet{
            switch currentState {
            case .signUp:
                header = .home
       
            case  .inputData,.selectCitizenship,.currentLive,.employmentStatus,.annualIncome,.netWorth:
                header = .back_home

                
            case .terms, .investorTerms:
                header = .back
            }
        }
    }
    @Published var registrationCompleted: Bool = false
    @Published var showingSheet: Bool = false
    @Published var loginProviderUrl: URL? 
    @Published var header: RegistrationHeader = .home
    
    //MARK: User data inputs
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var name: String = ""
    @Published var date: Date = Date()
    @Published var number: String = ""
    @Published var promocode: String = ""
    
    @Published var countryCode: String = ""
    
    @Published var currentCountryCode: String = ""
    @Published var cityCode: String = ""
    @Published var address: String = ""
    
    @Published var status: EmployedStatus?
    
    @Published var annualIncome: AnnualIncome?
    
    @Published var worth: NetWorth?
    @Published var user: User?
    
    
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    init(){
        
    }
    func getScan(text: String?) {
        if let current = text {
            current.map{ "shgg\($0)" }
        }
    }
    func loginWithApple() {
      loginProviderUrl =   networking.login_withProvider(provider: .Apple)
        showingSheet.toggle()

    }
    
    func loginWithGoogle() {
        loginProviderUrl =   networking.login_withProvider(provider: .Google)
        showingSheet.toggle()
    }
    
    
    func register(){
        networking.register(email: email, password: password)
            
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
                            currentState = currentState.next()
                        }
            .store(in: &subscriptions)
        
    }
    func updateUser() {
        networking.updateUser(name: name,
                              birth: "\(date)",
                              phone: number,
                              citizenship: countryCode,
                              country: currentCountryCode,
                              city: cityCode,
                              address: address,
                              employment: status?.text,
                              organization: "",
                              org_role: "",
                              working_period: "",
                              industry: "",
                              income: annualIncome?.value,
                              net_worth: worth?.value)
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
//                            currentState = currentState.next()
//                        }
//            .store(in: &subscriptions)
    }
    
    func forgetPassword(){
        
    }
    func newPassword(){
        
    }
}




enum RegistrationHeader{
    case home, back, back_home, skip
}

enum RegistrationStates: CaseIterable{
    case signUp, inputData, selectCitizenship, currentLive, employmentStatus, annualIncome, netWorth, terms, investorTerms
}


enum EmployedStatus:String,CaseIterable{

    case employed, selfEmployed
    var text: String{
        switch self {
        case .employed:
            "I'm employed"
        case .selfEmployed:
            "I'm self-employed"
        }
    }
}


enum AnnualIncome:String,  CaseIterable{
    case from0 , from50K, from100k, from250k
    var value: String {
        switch self {
        case .from0:
            "$0 - $50,000"
        case .from50K:
            "$50,000 - $100,000"
        case .from100k:
            "$100,000 - $250,000"
        case .from250k:
            "$250,00+"
        }
    }
}

enum NetWorth: String, CaseIterable{
    case from0 , from50K, from100k, from250k, from500k, from1m
    var value: String {
        switch self {
        case .from0:
            "$0 - $50,000"
        case .from50K:
            "$50,000 - $100,000"
        case .from100k:
            "$100,000 - $250,000"
        case .from250k:
            "$250,00- $500,000"
        case .from500k:
            "$500,000 - $1,000,000"
        case .from1m:
            "$1,000,000+"
        }
    }
}
