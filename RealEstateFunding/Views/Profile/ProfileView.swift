//
//  ProfileView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.09.2023.
//

import SwiftUI

struct ProfileView: View {
    @State var notify: Bool = false
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack{
                HStack{
                    Text("My Profile")
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
                    
                    Label("Delete Account", systemImage: "trash")
                        .foregroundColor(.red)
                        .padding(.bottom,20)
                        .padding(.top, 30)
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
            HStack{
                Text("Personal Information")
                    .font(.system(size: 20).weight(.semibold))
                    .foregroundColor(.black)
                 Spacer()
            }
            
            HStack{
                Text("Full name")
                    .font(.system(size: 15))
                 Spacer()
                
                Text("John Due")
                    .font(.system(size: 16).weight(.semibold))
                    
            }
            .foregroundColor(.black)
            .padding(.top)
            
            HStack{
                Text("Email")
                    .font(.system(size: 15))
                 Spacer()
                
                Text("email@example.com")
                    .font(.system(size: 16).weight(.semibold))
                 Image(systemName: "square.on.square")
                    .foregroundColor(.gray)
                    
            }
            .foregroundColor(.black)
            .padding(.top)
            
            HStack{
                Text("Phone number")
                    .font(.system(size: 15))
                 Spacer()
                
                Text("+123456789")
                    .font(.system(size: 16).weight(.semibold))
                 Image(systemName: "square.on.square")
                    .foregroundColor(.gray)
                    
            }
            .foregroundColor(.black)
            .padding(.top)
            
            HStack{
                Text("Investor Type")
                    .font(.system(size: 15))
                 Spacer()
                
                Text("Retail")
                    .font(.system(size: 16).weight(.semibold))
                 Image(systemName: "info.circle")
                    .foregroundColor(.gray)
                    
            }
            .foregroundColor(.black)
            .padding(.top)
            
            Button{
                
            } label: {
                Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(.red)
            }
            .padding(.top)
           
        }
        .modifier(CornerBackground())
    }
    
    private var preferencesView: some View {
        VStack{
            HStack{
                Text("Preferences")
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.bold))
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4){
                Text("Currency")
                    
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
                Text("Language")
                HStack{
                    Image("person")
                     Text("English")
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
                    Text("App notifications")
                        .font(.system(size: 16))
                     Spacer()
                     Toggle("", isOn: $notify)
                }
                 Text("Receive notifications when  you're paid rent, when new properties are launched, and more.")
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
                 Text("Submit Feedback")
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
                 Text("Terms and Conditions")
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
                 Text("Privacy and Conditions")
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
                 Text("Rate the App")
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
