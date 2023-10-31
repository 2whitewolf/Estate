//
//  SignUpView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI
import iPhoneNumberField



struct SignUpView: View {
    
    @EnvironmentObject var vm: RegistrationViewModel
   
 
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                
                Text("Sign Up")
                    .font(.system(size: 28).weight(.bold))
                    .foregroundColor(.black)
                Text("In Less Than 5 Minutes, You Can Start Growing Your Wealth.")
                    .foregroundColor(.customGray)
                
                textFields
                    .padding(.top,40)
                
                
                
                
                Text("Passwords must be at least 6 characters and contain at least one letter and one number.")
                    .foregroundColor(.customGray)
                    .font(.system(size: 12))
                
                HStack{
                    Spacer()
                    Text("Already have an account?")
                        .foregroundColor(.customGray) + Text(" Sign in")
                        .foregroundColor(.blue)
                    Spacer()
                }
                .padding(.top,40)
                .font(.system(size: 12))
                
                Spacer()
                
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
            WebRepresent(url: vm.loginProviderUrl!)
              }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(RegistrationViewModel())
    }
}


extension SignUpView {
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
            
            Button{
                vm.register()
//                RegistrationViewScreen()
//                withAnimation{
//                    vm.currentState =  vm.currentState.next()
//                }
                
            } label: {
                Text("Create account")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .backgroundColor(.blue)
                    .cornerRadius(12)
            }
            
            
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
