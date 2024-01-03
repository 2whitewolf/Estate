//
//  ForgotPasswordView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 15.09.2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @EnvironmentObject var vm: LoginViewModel
    
        var body: some View {
            ZStack{
                Color.white
                
                VStack{
                    HStack{
                        Text("Forgot Password ?")
                            .font(.system(size: 28).weight(.bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    VStack{
                        Text("You will receive a link in your inbox to reset your password.")
                            .foregroundColor(.gray)
                            .padding(.top)
                        
                        textFields
                            .padding(.top,40)
                        
                        
                        Button {
//                            vm.forgetPassword()
                            vm.state = vm.state.next()
                        } label: {
                            Text("Reset Password")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .backgroundColor(vm.emailToChange.isEmpty ? .customGray : .blue)
                                .cornerRadius(12)
                        }
                        .padding(.top,40)
                        .disabled(vm.emailToChange.isEmpty)
                    }
                    Spacer()
                    
                }
                .padding(.bottom, 20)
                .foregroundColor(.customGray)
                .padding(.horizontal,24)
            }
                
        }
    }

    extension ForgotPasswordView {
        private var textFields: some View {
            VStack{
                TextField("email@example", text: $vm.emailToChange)
                    .textFieldStyle(ImageWithLineStroke(title: "Email", image: Image("email")))
            }
        }
    }

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(LoginViewModel())
    }
}
