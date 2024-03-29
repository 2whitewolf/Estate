//
//  EmploymentStatusView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 27.10.2023.
//

import SwiftUI

struct EmploymentStatusView: View {
    @EnvironmentObject var vm: RegistrationViewModel
   
 

    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                    Text("[First Name],  what is your employment status?".localized)
                        .foregroundColor(.black)
                        .font(.system(size: 28).weight(.bold))
                    
                    Spacer()
                }
                HStack{
                    Text("You're just 3 steps away from gaining full access to our platform! Before you can join our growing community of [AppName] Investors, we need you to provide a little more information.".localized)
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
                    
                    ForEach(EmployedStatus.allCases, id: \.rawValue) { status in 
                        Button{
                            vm.status = status
                        } label: {
                            ZStack(alignment: .leading){
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(vm.status == status ? Color.blue : Color.gray, lineWidth: 0.5)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                Text(status.text)
                                    .foregroundColor(vm.status == status ? Color.blue : Color.black)
                                    .fontWeight(.semibold)
                                    .padding(.leading)
                            }
                        }
                      
                       
                           
                    }
                }
                .padding(.vertical)
                Spacer()
                
                Button {
                    withAnimation{
                        vm.currentState =  vm.currentState.next()
                    }
                  
                } label: {
                    Text("Next".localized)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background((vm.status != nil) ? Color.blue : Color.gray)
                        .cornerRadius(12)
                }
                .padding(.bottom, 20)
                .disabled(vm.status == nil)
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    EmploymentStatusView()
        .environmentObject(RegistrationViewModel())
}
