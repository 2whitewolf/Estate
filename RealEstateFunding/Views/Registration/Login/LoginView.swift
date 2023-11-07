//
//  LoginView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 13.09.2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var vm: LoginViewModel
    @State var forgetPasswordTapped: Bool = false
    var body: some View {
        ZStack{
                Color.white.ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Welcome back!")
                            .font(.system(size: 28).weight(.bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    textFields
                        .padding(.top,40)
                    
                    
                    Button{
                        vm.login()
                    } label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .backgroundColor(.blue)
                            .cornerRadius(12)
                    }
                    .padding(.top,40)
                    
                    Text("Forget a password")
                        .foregroundColor(.blue)
                        .font(.system(size: 12))
                        .onTapGesture {
                            vm.state = vm.state.next()
                        }
                        .padding()
                        .padding(.top,8)
                    Spacer()
                    
                    HStack{
                        Spacer()
                        Text("Don't have an account?")
                            .foregroundColor(.customGray) + Text(" Sign up")
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    .padding(.top,40)
                    .font(.system(size: 12))
                    
                    
                    
                    buttonsView
                    VStack{
                        Text("By logging in, you have agreed to the") + Text(" Terms And Conditions")   .foregroundColor(.blue) + Text(" and ") + Text("Privacy Policy.")
                            .foregroundColor(.blue)
                    }
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12))
                    
                    
                }
                .padding(.bottom, 20)
                .foregroundColor(.customGray)
                .padding(.horizontal,24)
        }
        .sheet(isPresented: $vm.showingSheet) {
            WebRepresent(user: $vm.user, url: vm.loginProviderUrl!)
              }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
    }
}


extension LoginView {
    private var textFields: some View {
        VStack{
            TextField("email@example", text: $vm.email)
                .textFieldStyle(ImageWithLineStroke(title: "Email", image: Image("email")))
            
            SecureField("Password", text: $vm.password)
                .textFieldStyle(ImageWithLineStroke(title: "Password", image: Image("password")))
            
            
        }
        
        
    }
    private var buttonsView: some View {
        VStack{
            Button {
                vm.loginWithApple()
            } label: {
                HStack{
                    Image(systemName: "apple.logo")
                        .foregroundColor(.black)
                    
                    Text("Sign up with Apple")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 1)
                )
            }
            Button {
                vm.loginWithGoogle()
            } label: {
                
                HStack{
                    Image("googleLogo")
                    
                    Text("Sign up with Google")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 1)
                )
            }
        }
    }
}

