//
//  RegistrationHeaderView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 30.10.2023.
//

import SwiftUI

struct RegistrationHeaderView: View {
    @EnvironmentObject var appVM: AppViewModel
    @EnvironmentObject var vm: RegistrationViewModel
    var body: some View {
        switch vm.header {
        case .home:
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
            .padding(.horizontal, 24)
        case .back:
            HStack{
                Button{
                    withAnimation{
                        vm.currentState = vm.currentState.previous()
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                    
                        .background(Circle().stroke(Color.gray, lineWidth: 0.5).frame(width:44, height:44))
                        .frame(width:44, height:44)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
        case .back_home:
            HStack{
                Button{
                    withAnimation{
                        vm.currentState = vm.currentState.previous()
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                    
                        .background(Circle().stroke(Color.gray, lineWidth: 0.5).frame(width:44, height:44))
                        .frame(width:44, height:44)
                }
                Spacer()
                
                Button{
                    withAnimation{
                        vm.currentState = .signUp
                    }
                } label: {
                    Image(systemName: "house")
                        .foregroundColor(.blue)
                    
                        .background(Circle().stroke(Color.gray, lineWidth: 0.5).frame(width:44, height:44))
                        .frame(width:44, height:44)
                }
            }
            .padding(.horizontal, 24)
        case .skip:
            HStack{
                Spacer()
                Button{
                    withAnimation{
                        vm.currentState = vm.currentState.next()
                    }
                }label: {
                    Text("Skip")
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    RegistrationHeaderView()
        .environmentObject(RegistrationViewModel())
}
