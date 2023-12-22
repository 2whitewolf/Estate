//
//  NetWorthView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 27.10.2023.
//

import SwiftUI

struct NetWorthView: View {
    
    @EnvironmentObject var vm: RegistrationViewModel
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                    Text("[First Name],  what is your net worth?".localized)
                        .foregroundColor(.black)
                        .font(.system(size: 28).weight(.bold))
                    
                    Spacer()
                }
                HStack{
                    Text("To ensure we provide you with the most suitable investments for you, please select the value of your current net worth:".localized)
                        .foregroundColor(.gray)
                    Spacer()
                }
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
                
                VStack(alignment: .leading, spacing: 8){
                    Text("Please select one".localized)
                        .font(.system(size: 13))
                    ScrollView(showsIndicators: false) {
                        ForEach(NetWorth.allCases, id: \.rawValue) { status in
                            Button{
                                vm.worth = status
                            } label: {
                                ZStack(alignment: .leading){
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(vm.worth == status ? Color.blue : Color.gray, lineWidth: 0.5)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                    Text(status.value)
                                        .foregroundColor(vm.worth == status ? Color.blue : Color.black)
                                        .fontWeight(.semibold)
                                        .padding(.leading)
                                }
                            } 
                        }
                    }
                }
                .padding(.vertical)
                Spacer()
                
                Button {
                    withAnimation{
                        vm.currentState =  vm.currentState.next()
                        vm.updateUser()
                    }
                    
                } label: {
                    Text("Next".localized)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background((vm.worth != nil) ? Color.blue : Color.gray)
                        .cornerRadius(12)
                }
                .padding(.bottom, 20)
                .disabled(vm.worth == nil)
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    NetWorthView()
        .environmentObject(RegistrationViewModel())
}
