//
//  ProfileView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.09.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State var notify: Bool = false
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack{
                HStack{
                    Text("My Profile".localized)
                        .foregroundColor(.black)
                        .font(.system(size: 34).weight(.bold))
                    Spacer()
                }
                .padding(.leading,22)
                .padding(.top,50)
                ScrollView(showsIndicators: false) {
                    
                    personalInfoView
                    
                    preferencesView
                    
                    appInfo
                    Button {
                        appVM.logout()
                    } label: {
                        Label("Delete Account".localized, systemImage: "trash")
                            .foregroundColor(.red)
                            .padding(.bottom,20)
                            .padding(.top, 30)
                    }
                }
                
            }.padding(.horizontal,8)
               
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


extension ProfileView {
    private var personalInfoView: some View {
        VStack{
            if let user = appVM.user {
                HStack{
                    Text("Personal Information".localized)
                        .font(.system(size: 20).weight(.semibold))
                        .foregroundColor(.black)
                    Spacer()
                }
                
                HStack{
                    Text("Full name".localized)
                        .font(.system(size: 15))
                    Spacer()
                    
                    Text(user.name ?? "")
                        .font(.system(size: 16).weight(.semibold))
                    
                }
                .foregroundColor(.black)
                .padding(.top)
                
                HStack{
                    Text("Email".localized)
                        .font(.system(size: 15))
                    Spacer()
                    
                    Text(user.email ?? "")
                        .font(.system(size: 16).weight(.semibold))
                    Image(systemName: "square.on.square")
                        .foregroundColor(.gray)
                    
                }
                .foregroundColor(.black)
                .padding(.top)
                
                HStack{
                    Text("Phone number".localized)
                        .font(.system(size: 15))
                    Spacer()
                    
                    Text(user.phone ?? "\(user.id)" ?? "")
                        .font(.system(size: 16).weight(.semibold))
                    Image(systemName: "square.on.square")
                        .foregroundColor(.gray)
                    
                }
                .foregroundColor(.black)
                .padding(.top)
                
                HStack{
                    Text("Investor Type".localized)
                        .font(.system(size: 15))
                    Spacer()
                    
                    Text("Retail".localized)
                        .font(.system(size: 16).weight(.semibold))
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                    
                }
                .foregroundColor(.black)
                .padding(.top)
                
                Button{
                    appVM.logout()
                } label: {
                    Label("Log Out".localized, systemImage: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.red)
                }
                .padding(.top)
            }
        }
        .modifier(CornerBackground())
    }
    
    private var preferencesView: some View {
        VStack{
            HStack{
                Text("Preferences".localized)
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.bold))
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4){
                Text("Currency".localized)
                    
                HStack{
                    Image("person")
                     Text("AED")
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.gray, lineWidth: 0.5))
            }
            .foregroundColor(.black)
            VStack(alignment: .leading, spacing: 4){
                Text("Language".localized)
                HStack{
                    Image("person")
                    Text("English".localized)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.gray, lineWidth: 0.5))
            }
            .foregroundColor(.black)
            
            Divider()
            
            VStack(alignment: .leading){
                HStack{
                    Text("App notifications".localized)
                        .font(.system(size: 16))
                     Spacer()
                     Toggle("", isOn: $notify)
                }
                Text("Receive notifications when  you're paid rent, when new properties are launched, and more.".localized)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 0.5))
            .foregroundColor(.black)
            
        }
        .modifier(CornerBackground())

    }
    
    private var appInfo: some View {
        VStack{
            HStack{
                Text("[App Name]")
                    .font(.system(size: 28).weight(.bold))
                    .foregroundColor(.black)
                Spacer()
                
            }
            
            
            HStack{
                Image(systemName: "doc.text")
                    .foregroundColor(.blue)
                Text("Submit Feedback".localized)
                    .foregroundColor(.black)
                 Spacer()
                 Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(Color.lightBlue.opacity(0.6))
            .cornerRadius(12)
            
            
            HStack{
                Image(systemName: "doc.text")
                    .foregroundColor(.blue)
                Text("Terms and Conditions".localized)
                    .foregroundColor(.black)
                 Spacer()
                 Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(Color.lightBlue.opacity(0.6))
            .cornerRadius(12)
            
            
            HStack{
                Image(systemName: "shield")
                    .foregroundColor(.blue)
                Text("Privacy and Conditions".localized)
                    .foregroundColor(.black)
                 Spacer()
                 Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(Color.lightBlue.opacity(0.6))
            .cornerRadius(12)
            
            HStack{
                Image(systemName: "star.fill")
                    .foregroundColor(.blue)
                Text("Rate the App".localized)
                    .foregroundColor(.black)
                 Spacer()
                 Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(Color.lightBlue.opacity(0.6))
            .cornerRadius(12)
            
        }
        .font(.system(size: 16))
        .modifier(CornerBackground())
    }
}
