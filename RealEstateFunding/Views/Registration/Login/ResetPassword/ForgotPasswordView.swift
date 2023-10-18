//
//  ForgotPasswordView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 15.09.2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    enum PasswordReset{
        case sendRequest, emailSended, resetPassword
    }

        @State var email: String = ""
    @State var state : PasswordReset = .sendRequest

        var body: some View {
            ZStack{
                Color.white.ignoresSafeArea()
                switch state {
                case .sendRequest:
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
                                state = .emailSended
                            } label: {
                                Text("Reset Password")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .backgroundColor(.blue)
                                    .cornerRadius(12)
                            }
                            .padding(.top,40)
                        }
                         Spacer()
                        
                    }
                    .padding(.bottom, 20)
                    .foregroundColor(.customGray)
                    .padding(.horizontal,24)
                    
                case .emailSended:
                    VStack{
                        
                    }
                    
                case.resetPassword:
                    EnterNewPasswordView()
                }
               
                
               
                

            }
        }
    }

    extension ForgotPasswordView {
        private var textFields: some View {
            VStack{
                TextField("email@example", text: $email)
                    .textFieldStyle(ImageWithLineStroke(title: "Email", image: Image("email")))
            }
        }
    }

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
