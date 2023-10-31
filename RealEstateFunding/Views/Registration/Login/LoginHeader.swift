//
//  LoginHeader.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 31.10.2023.
//

import SwiftUI

struct LoginHeader: View {
    @EnvironmentObject var appVM: AppViewModel
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        switch vm.state {
        case .login:
            HStack{
                Spacer()
                
                Button{
                    withAnimation{
                        appVM.currentState = .appStart
                    }
                } label: {
                    Image(systemName: "house")
                        .foregroundColor(.blue)
                    
                        .background(Circle().stroke(Color.gray, lineWidth: 0.5).frame(width:44, height:44))
                        .frame(width:44, height:44)
                }
            }
            .padding(.horizontal,26)
        case .forgotPassword:
            HStack{
                Button{
                    withAnimation{
                        vm.state = vm.state.previous()
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                    
                        .background(Circle().stroke(Color.gray, lineWidth: 0.5).frame(width:44, height:44))
                        .frame(width:44, height:44)
                }
                Spacer()
            }
            .padding(.horizontal,26)
        case .sended:
            HStack{
                Button{
                    withAnimation{
                        vm.state = .login
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                    
                        .background(Circle().stroke(Color.gray, lineWidth: 0.5).frame(width:44, height:44))
                        .frame(width:44, height:44)
                }
                Spacer()
            }
            .padding(.horizontal,26)
        case .changePassword:
            HStack{
               Spacer()
                Button{
                    withAnimation{
                        vm.state = .login
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                    
                        .background(Circle().stroke(Color.gray, lineWidth: 0.5).frame(width:44, height:44))
                        .frame(width:44, height:44)
                }
            }
            .padding(.horizontal,26)
        }
    }
}

#Preview {
    LoginHeader()
        .environmentObject(LoginViewModel())
}
