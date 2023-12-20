//
//  InvestedSuccesView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 14.12.2023.
//

import SwiftUI

struct InvestedSuccesView: View {
    @EnvironmentObject var paymentViewModel: PaymentViewModel
    var body: some View {
        VStack(spacing: 8){
            Text("Receipt")
                .foregroundColor(.black)
                .font(.system(size: 17).weight(.semibold))
            
            
            VStack{
                Text("Investment\nConfirmed!")
                .font(.system(size: 34).weight(.bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                
                Text("An email confirmation including information about your investment and the property will be sent to you shortly.")
                    .font(.system(size: 12))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                .padding(.top,8)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.2, green: 0.78, blue: 0.35).opacity(0.16))
            .cornerRadius(32)
            .overlay(
            RoundedRectangle(cornerRadius: 32)
            .inset(by: 0.5)
            .stroke(Color(red: 0.2, green: 0.78, blue: 0.35), lineWidth: 1)
            )
            .padding(.top,10)
            VStack{
                Group{
                    Text("Total Investment amount")
                        .font(.system(size: 15).weight(.semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    
                    Text("AED 500.00")
                        .font(.system(size: 28).weight(.bold))
                        .foregroundColor(.blue)
                        .padding(.vertical,8)
                    
                    Text(Date().dateWithTime)
                    .font(Font.custom("SF Pro Text", size: 12))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                }
                
                HStack{
                    Text("Payment Method")
                        .foregroundColor(.black)
                        .font(.system(size: 16,weight: .semibold))
                    Spacer()
                    if let icon = paymentViewModel.paymentMethod.image {
                        Image(icon)
                    }
                }
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.gray, lineWidth: 0.5))
                .padding(.top,24)
                
                Button{
                    paymentViewModel.goBack()
                } label: {
                  Text("View Portfolio")
                        .font(.system(size: 17).weight(.semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(14)
                }
            }
            .modifier(CornerBackground())
            
            
            VStack(alignment: .leading){
                if let property = paymentViewModel.propertyDetail{
                    Text(property.about ?? "")
                        .font(.system(size: 17).weight(.semibold))
                            .foregroundColor(.black)
                    PropertyAboutCell(title: "Annualised return", detail: (property.annualProfit ?? "") + " %")
                    PropertyAboutCell(title: "Investment Period", detail: (property.period ?? "") + " Year")
                    if let investition = paymentViewModel.invetsmentsCost {
                        PropertyAboutCell(title: "Investment Amount", detail: "AED " + (investition.investmentCost?.rotate(2) ?? "0"))
                    }
                     
                     }
            }
            .modifier(CornerBackground())
            
            Spacer()
        }
        .padding(.horizontal,8)
    }
}

#Preview {
    InvestedSuccesView()
}


fileprivate struct PropertyAboutCell: View {
    var title: String
    var detail: String
    var body: some View {
        HStack{
            Text(title)
                .font(.system( size: 13))
            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
            
             Spacer()
            
            Text(detail)
                .font(.system(size: 13).weight(.semibold))
            .foregroundColor(.black)
        }
    }
}
