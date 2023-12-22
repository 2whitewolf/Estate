//
//  AnnualIncomeView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 27.10.2023.
//

import SwiftUI

struct AnnualIncomeView: View {
    @EnvironmentObject var vm: RegistrationViewModel
  
    
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                    Text("[First Name],  what is your annual income?".localized)
                        .foregroundColor(.black)
                        .font(.system(size: 28).weight(.bold))
                    
                    Spacer()
                }
                HStack{
                    Text("To ensure we provide you with the most suitable investments for you, please select which annual income bracket best represents you currently:".localized)
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
                        ForEach(AnnualIncome.allCases, id: \.rawValue) { status in
                            Button{
                                vm.annualIncome = status
                            } label: {
                                ZStack(alignment: .leading){
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke( vm.annualIncome == status ? Color.blue : Color.gray, lineWidth: 0.5)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                    Text(status.value)
                                        .foregroundColor( vm.annualIncome == status ? Color.blue : Color.black)
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
                    }
                    
                } label: {
                    Text("Next".localized)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(( vm.annualIncome != nil) ? Color.blue : Color.gray)
                        .cornerRadius(12)
                }
                .padding(.bottom, 20)
                .disabled( vm.annualIncome == nil)
            }
            .padding(.horizontal,24)
        }
    }
}




#Preview {
    AnnualIncomeView()
        .environmentObject(RegistrationViewModel())
}
