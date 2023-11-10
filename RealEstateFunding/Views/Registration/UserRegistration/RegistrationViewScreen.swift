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
            VStack{
                 RegistrationHeaderView()
                    .padding(.top,55)
                switch vm.currentState {
                case .signUp:
                    SignUpView()
                case .inputData:
                    FillUserDataView()
                case .selectCitizenship:
                    CitizenshipView()
                case .currentLive:
                    CurrentLiveView()
                case .employmentStatus:
                    EmploymentStatusView()
                case .annualIncome:
                    AnnualIncomeView()
                case .netWorth:
                    NetWorthView()
                case .terms:
                    TermsAndConditionsView()
                case .investorTerms:
                    InvestorTermsView()
              
                }
            }
        }
        .popup(isPresented: $vm.verifyEmail){
            VerifyMail()
                .environmentObject(vm)
                .cornerRadius(20, corners: [.topLeft, .topRight])
        } customize: {
            $0
                .type(.toast)
                .position(.bottom)
                .closeOnTap(false)
                .backgroundColor(.black.opacity(0.4))
        }
        .environmentObject(vm)
        .onChange(of: vm.registrationCompleted){ newValue in
            if newValue {
                withAnimation {
                    appVM.currentState = .app
                }
            }
        }
        .onChange(of: vm.user) { value in
            if let user = value {
                appVM.user = user
                vm.currentState = .inputData
            }
        }
    }
}

#Preview {
    RegistrationViewScreen()
}
