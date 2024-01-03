//
//  AppMainState.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 11.10.2023.
//

import SwiftUI

struct AppMainState: View {
    @StateObject var vm: AppViewModel = AppViewModel()
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            switch vm.currentState {
            case .onboarding:
                OnboardingView()
            case .login:
                LoginViewScreen()
                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            case .registration:
                RegistrationViewScreen()
                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            case .app:
                CustomTabBar()
            case .appStart:
                RegistrationStartView()

            }
        }
        .environmentObject(vm)
       
           
    }
}

#Preview {
    NavigationView {
        AppMainState()
    }
    .navigationViewStyle(StackNavigationViewStyle())
}
