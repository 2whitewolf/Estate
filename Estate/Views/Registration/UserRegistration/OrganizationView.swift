//
//  OrganizationView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 26.12.2023.
//

import SwiftUI

struct OrganizationView: View {
    @EnvironmentObject var vm: RegistrationViewModel
    @State var name: String = ""
    var body: some View {
        VStack{
            Text("[First Name], tell us more about the organization".localized)
            .font(.system(size: 28).weight(.bold))
            .foregroundColor(.black)
            
            Text("You're just 3 steps away from gaining full access to our platform! Before you can join our growing community of [AppName] Investors, we need you to provide a little more information.".localized)
                .font(.system(size: 17))
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
            
            Button {
                
            } label: {
                Label("Why we ask".localized, systemImage: "info.circle")
                    .foregroundColor(.black)
                    .font(.system(size: 13).weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
            }
            
            Spacer()
            
            VStack(spacing:16){
                TextField("Organization Name", text: $name)
                    .textFieldStyle(TitleAndLineStroke(title: "Name of your organization".localized))
                
                role

                period
                
                industry
            }
            
            
            
            
            
            
            Button {
                withAnimation{
                    vm.currentState =  vm.currentState.next()
                }
              
            } label: {
                Text("Next".localized)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background( Color.blue)
                    .cornerRadius(12)
            }
//            .disabled(vm.countryCode.isEmpty)
            .padding(.bottom, 20)
        }
        .padding(.horizontal,24)
    }
}

#Preview {
    OrganizationView()
        .environmentObject(RegistrationViewModel())
}


extension OrganizationView{
    private var role: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("What is your role".localized)
                .font(.system(size: 13))
            
            if true {
                HStack{
                    
                    Text("Select your country".localized)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                        .onTapGesture {
                          
                        }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            } else {
                HStack{
//                    Text(countryFlag(vm.currentCountryCode))
//                    Text(Locale.current.localizedString(forRegionCode: vm.currentCountryCode) ?? "")
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                        .onTapGesture {
                        }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            }
            
            
        }
//        .padding(.vertical)
    }
    
    
    private var period: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("How long have you been working here?".localized)
                .font(.system(size: 13))
            
            if true {
                HStack{
                    
                    Text("Select period".localized)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                        .onTapGesture {
                          
                        }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            } else {
                HStack{
//                    Text(countryFlag(vm.currentCountryCode))
//                    Text(Locale.current.localizedString(forRegionCode: vm.currentCountryCode) ?? "")
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                        .onTapGesture {
                        }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            }
            
            
        }
//        .padding(.vertical)
    }
    
    
    private var industry: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("What industry your organization in?".localized)
                .font(.system(size: 13))
            
            if true {
                HStack{
                    
                    Text("Select industry".localized)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                        .onTapGesture {
                          
                        }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            } else {
                HStack{
//                    Text(countryFlag(vm.currentCountryCode))
//                    Text(Locale.current.localizedString(forRegionCode: vm.currentCountryCode) ?? "")
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                        .onTapGesture {
                        }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            }
            
            
        }
//        .padding(.vertical)
    }
    
    
}
