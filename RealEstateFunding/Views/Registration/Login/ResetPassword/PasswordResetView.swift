//
//  PasswordReset.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 31.10.2023.
//

import SwiftUI

struct PasswordResetView: View {
    @EnvironmentObject var vm: LoginViewModel
    @State var openInbox: Bool = false
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
                .padding(.horizontal,22)
                
                VStack{
                    
                    Image(systemName: "envelope.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:72)
                        .foregroundColor(.blue)
                    
                    Text("Password Reset Successfully")
                        .font(.system(size: 20).weight(.semibold))
                        .foregroundColor(.black)
                    
                    Text("We have sent you a link at email@example.com.\nPlease click on the link your inbox to reset your password.")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    
                }
                .modifier(CornerBackground())
                .frame(height: 200)
                
                Spacer()
                
                Button {
                    openInbox.toggle()
                    //   vm.changePassword()
                } label: {
                    Text("Open Inbox")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .backgroundColor(.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
               
                .confirmationDialog("Open mail app\nWhich app would you like to open?", isPresented: $openInbox, titleVisibility: .visible) {
                    Button("Mail") {
                        
                        if let url = URL(string: "mailto:") {
                            UIApplication.shared.open(url)
                        }
                        
                    }
                    
                    Button("Gmail") {
                        if let url = URL(string: "googlegmail:") {
                            UIApplication.shared.open(url)
                        }
                    }
                    
                    
                }
                
            }
            .padding(.bottom, 20)
            .foregroundColor(.customGray)
            .padding(.horizontal,8)
        }
    }
}

#Preview {
    PasswordResetView()
}
