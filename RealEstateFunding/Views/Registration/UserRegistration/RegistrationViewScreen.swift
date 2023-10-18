//
//  RegistrationViewScreen.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 05.10.2023.
//

import SwiftUI

struct RegistrationViewScreen: View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var vm: RegistrationViewModel = RegistrationViewModel()
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
//            if vm.registrationCompleted {
//                CustomTabBar()
//                    .navigationBarHidden(true)
//            } else {
                switch vm.currentState {
                case .signUp:
                    SignUpView()
                case .inputData:
                    FillUserDataView()
                case .selectCountry:
                    SelectCountryView()
                case .from:
                    SelectCountryView()
                case .terms:
                    TermsAndConditionsView()
                case .investorTerms:
                    InvestorTermsView()
                }
                
//            }
            
        }
        .environmentObject(vm)
        .onChange(of: vm.registrationCompleted){ newValue in
            if newValue {
                withAnimation {
                    appVM.currentState = .app
                }
            }
        }
    }
}

#Preview {
    RegistrationViewScreen()
}
