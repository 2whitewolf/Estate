//
//  EnterNewPasswordView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.09.2023.
//

import SwiftUI

struct EnterNewPasswordView: View {
    @State var password: String = ""
    @State var repeatPassword: String = ""
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                     Text("Enter New Password")
                        .font(.system(size: 34).weight(.bold))
                        .foregroundColor(.black)
                    Spacer()
                }
                VStack{
                    SecureField("Password", text: $password)
                        .textFieldStyle(ImageWithLineStroke(title: "Password", image: Image("password")))
                    
                    SecureField("Confirm Password", text: $repeatPassword)
                        .textFieldStyle(ImageWithLineStroke(title: "Confirm Password", image: Image("password")))
                    
                    
                }
                .padding(.top,25)
                
                Button{
                    
                } label: {
                    Text("Change Password")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .backgroundColor(.blue)
                        .cornerRadius(12)
                }
                .padding(.top,40)
                Spacer()
                
            }
            .padding(.horizontal,24)
            .padding(.bottom,20)
        }
    }
}

struct EnterNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        EnterNewPasswordView()
    }
}
