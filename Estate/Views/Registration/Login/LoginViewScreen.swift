//
//  LoginViewScreen.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 31.10.2023.
//

import SwiftUI

struct LoginViewScreen: View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var vm: LoginViewModel = LoginViewModel()
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                 LoginHeader()
                    .environmentObject(appVM)
                    .environmentObject(vm)
//                    .padding(.top,55)
                switch vm.state {
                case .login:
                    LoginView()
                case .forgotPassword:
                    ForgotPasswordView()
                case .sended:
                   PasswordResetView()
                case .changePassword:
                    EnterNewPasswordView()
                }
            }
        }
        .environmentObject(vm)
        .onChange(of: vm.user) { user in
            if let user = user {
                appVM.user = user
                appVM.currentState = .app
            }
        }
    }
}

#Preview {
    LoginViewScreen()
        .environmentObject(AppViewModel())
}
