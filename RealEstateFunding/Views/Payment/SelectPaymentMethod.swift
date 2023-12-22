//
//  SelectPaymentMethod.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 04.12.2023.
//

import SwiftUI

struct SelectPaymentMethod: View {
    @EnvironmentObject var vm: PaymentViewModel
    var onClose: () -> Void
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "xmark.circle.fill")
                    .opacity(0)
                Spacer()
                Text("Payment Methods".localized)
                    .fontWeight(.bold)
                Spacer()
                Button{
                    onClose()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal,8)
            .padding(.vertical)
            
            Divider()
            
            
            VStack(alignment: .leading, spacing: 16){
                Text("Wallet".localized)
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                if let walletBalance = vm.walletBalance {
                    HStack{
                        Image(systemName: vm.paymentMethod == .wallet ? "checkmark.circle.fill" : "circle" )
                            .foregroundColor(.gray)
                        Text("AED " + (walletBalance.balance?.rotate(0) ?? ""))
                            .font(.system(size: 15).weight(.semibold))
                        Spacer()
                        if !vm.canPayWithWallet() {
                            HStack(spacing:4){
                                Circle()
                                    .fill(Color.red)
                                    .frame(width:8)
                                
                                Text("Low Balance".localized)
                                    .font(.system(size: 11).weight(.semibold))
                                    .kerning(0.06)
                                    .foregroundColor(.black)
                            }
                            .padding(.vertical,4)
                            .padding(.horizontal,8)
                            .background(Color.red.opacity(0.16))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 1, green: 0.23, blue: 0.19), lineWidth: 1)
                                
                            )
                        }
                    }
                    .foregroundColor(.gray)
                    
                }
            }
//            .disabled(!vm.canPayWithWallet())
            .modifier(CornerBackground())
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke( Color.blue,lineWidth: vm.paymentMethod == .wallet ? 1 : 0)
            )
            .onTapGesture {
                if vm.canPayWithWallet() {
                    withAnimation{
                        vm.paymentMethod = .wallet
                    }
                }
            }
            
            
            VStack(alignment: .leading, spacing: 4){
                Text("Cards".localized)
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                Text("Retail investors can only use debit cards for payment".localized)
                    .font(Font.custom("SF Pro Text", size: 13))
                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                HStack{
                    Image(systemName: vm.paymentMethod == .stripe ? "checkmark.circle.fill" : "circle" )
                        .foregroundColor(.blue)
                    Text("Stripe".localized)
                        .font(.system(size: 15).weight(.semibold))
                    Spacer()
                    Image("stripe_icon")
                }
                .foregroundColor(.black)
                .padding(.top,17)
            }
            .modifier(CornerBackground())
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke( Color.blue,lineWidth: vm.paymentMethod == .stripe ? 1 : 0)
            )
            .onTapGesture {
                withAnimation{
                    vm.paymentMethod = .stripe
                }
            }
            
            VStack(alignment: .leading, spacing: 17){
                Text("Other methods".localized)
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                HStack{
                    Image(systemName: vm.paymentMethod == .apple ? "checkmark.circle.fill" : "circle" )
                        .foregroundColor(.blue)
                    Text("Apple Pay".localized)
                        .font(.system(size: 15).weight(.semibold))
                    Spacer()
                    Image("apple_pay_icon")
                }
                .foregroundColor(.black)
                .onTapGesture{
                    withAnimation{
                        vm.paymentMethod = .apple
                    }
                }
                
                HStack{
                    Image(systemName: vm.paymentMethod == .crypto ? "checkmark.circle.fill" : "circle" )
                        .foregroundColor(.blue)
                    Text("Crypto".localized)
                        .font(.system(size: 15).weight(.semibold))
                    Spacer()
                    Image("crypto_icon")
                }
                .foregroundColor(.black)
                .onTapGesture{
                    withAnimation{
                        vm.paymentMethod = .crypto
                    }
                }
            }
            .modifier(CornerBackground())
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke( Color.blue,lineWidth: vm.paymentMethod == .crypto || vm.paymentMethod == .apple ? 1 : 0)
            )
            Spacer()
            Button{
                onClose()
            } label: {
                Text("Continue".localized)
                    .foregroundColor(.white)
                    .font(.system(size: 17).weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height:50)
                    .background(Color.blue)
                    .cornerRadius(14)
            }
            .padding()
            .padding(.bottom,22)
        }
        .padding(.horizontal,8)
        .cornerRadius(20)
    }
        
}

#Preview {
    SelectPaymentMethod(onClose: {})
        .environmentObject(PaymentViewModel())
}
