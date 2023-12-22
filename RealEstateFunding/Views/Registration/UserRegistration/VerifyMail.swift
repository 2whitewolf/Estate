//
//  VerifyMail.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 06.11.2023.
//

import SwiftUI

struct VerifyMail: View {
    @EnvironmentObject var vm: RegistrationViewModel
    @State var openInbox: Bool = false
    var body: some View {
//        ZStack{
//            Color.white.ignoresSafeArea()
            VStack{
                
                Color.black
                    .opacity(0.2)
                    .frame(width: 30, height: 6)
                    .clipShape(Capsule())
                    .padding(.top, 15)
                    .padding(.bottom, 10)
                VStack{
                    
                    Image(systemName: "envelope.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:72)
                        .foregroundColor(.blue)
                    
                    Text("Your email hasn't been verified yet".localized)
                        .font(.system(size: 20).weight(.semibold))
                        .foregroundColor(.black)
                    
                    Text("We have sent you a link at".localized  + " ")
                        .font(.system(size: 12))
                        .foregroundColor(.gray) +
                    Text(vm.email + " ")
                        .font(.system(size: 12))
                        .foregroundColor(.blue)
                    +
                    Text("Please click on the link your inbox to reset your password.".localized)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                }
                .modifier(CornerBackground())
                .frame(height: 200)
                .padding(.horizontal,1)
                 Spacer()
               
                
                
                Button {
                    openInbox.toggle()
                    //   vm.changePassword()
                } label: {
                    Text("Open Inbox".localized)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .backgroundColor(.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom,50)
               
                .confirmationDialog("Open mail app\nWhich app would you like to open?".localized, isPresented: $openInbox, titleVisibility: .visible) {
                    Button("Mail".localized) {
                        vm.currentState.next()
                        if let url = URL(string: "mailto:") {
                            UIApplication.shared.open(url)
                        }
                        
                    }
                    
                    Button("Gmail".localized) {
                        vm.currentState.next()
                        if let url = URL(string: "googlegmail:") {
                            UIApplication.shared.open(url)
                        }
                    }
                    
                    
                }
            }
            .background(Color.white)
//        }
    }
}

#Preview {
    VerifyMail()
}
