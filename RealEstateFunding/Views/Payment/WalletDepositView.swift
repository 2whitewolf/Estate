//
//  WalletDepositView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 20.12.2023.
//

import SwiftUI

struct WalletDepositView: View {
    @EnvironmentObject var vm: PaymentViewModel
    var body: some View {
        VStack{
            
            VStack(spacing: 24) {
                Image("walletAdd")
                VStack(spacing:8){
                    Text("AED " + vm.invest.rotate(2))
                        .foregroundColor(.blue)
                        .font(.system(size: 28).weight(.bold))
                    
                    
                    Text(Date().dateWithTime)
                        .font(Font.custom("SF Pro Text", size: 12))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(32)
            .overlay(
              RoundedRectangle(cornerRadius: 32)
                .inset(by: 0.5)
                .stroke(Color(red: 0.9, green: 0.9, blue: 0.92), lineWidth: 1)
            )
            
            
            
            VStack(spacing:24){
                
                HStack{
                    Text("Transaction ID")
                        .font(.system(size: 16))
                    .foregroundColor(.black)
                    
                     Spacer()
                    
                    Text("185947")
                    .font(.system( size: 16).weight(.semibold))
                    .foregroundColor(.black)
                     Image(systemName: "square.on.square")
                        .foregroundColor(.gray)
                        .font(.system(size:15).weight(.semibold))
                }
                
                HStack{
                    Text("New Cash Balance")
                        .font(.system(size: 16))
                    .foregroundColor(.black)
                    
                     Spacer()
                    
                    Text("AED " + (vm.walletBalance?.balance?.rotate(2) ?? "0"))
                    .font(.system( size: 16).weight(.semibold))
                    .foregroundColor(.black)
                }
                
                HStack{
                    Text("Status")
                        .font(.system(size: 16))
                    .foregroundColor(.black)
                    
                     Spacer()
                    
                    HStack(spacing: 4) {
                        Circle()
                            .fill(Color(red: 0.2, green: 0.78, blue: 0.35))
                            .frame(width:8)
                        Text("Completed")
                        .font(.system(size: 11).weight(.semibold))
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.97))

                    .cornerRadius(12)
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(32)
            .overlay(
              RoundedRectangle(cornerRadius: 32)
                .inset(by: 0.5)
                .stroke(Color(red: 0.9, green: 0.9, blue: 0.92), lineWidth: 1)
            )
            
            Spacer()
        }
    }
}

#Preview {
    WalletDepositView()
        .environmentObject(PaymentViewModel())
}
