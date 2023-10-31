//
//  RegistrationStratView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI
import AuthenticationServices

struct RegistrationStartView: View {
    @EnvironmentObject var appVM: AppViewModel
    var body: some View {
        ZStack(alignment: .bottom){
            Image("registrationBackgroundImage")
                .resizable()
                .scaledToFill()

                .ignoresSafeArea()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            
            VStack(alignment: .leading){
                Text("Property Investment Made Easy")
//                    .multilineTextAlignment(.leading)
                    .font(.system(size: 34).weight(.bold))
                   
                 Text("It's Time You Invest In Real Estate Your Own Way.")
                    .multilineTextAlignment(.leading)
                
                

                Button{
                    withAnimation{
                        appVM.currentState = .login
                    }

                } label: {
                    Text("Sign in")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height:60)

                }
                Button{
                    withAnimation{
                        appVM.currentState = .registration
                    }
                }label: {
                    Text("Create account")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height:60)
                        .background(Color.white)
                        .cornerRadius(12)
                }
                
                Text("By logging in, you have agreed to the") + Text(" Terms And Conditions")   .foregroundColor(.blue) + Text(" and ") + Text("Privacy Policy.")
                    .foregroundColor(.blue)
                   
            }
            .padding(.horizontal,24)
            .foregroundColor(.white)
            .padding(.bottom,40)
        }
    }
}

struct RegistrationStartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistrationStartView()
        }
    }
}
