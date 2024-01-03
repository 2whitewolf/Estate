//
//  CheckoutViewWithFunds.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 19.12.2023.
//

import SwiftUI
import PopupView
import Stripe
import StripePaymentSheet
import StripeApplePay

struct CheckoutFundsView: View {
    @Environment(\.presentationMode) var presented
    @EnvironmentObject var vm: PaymentViewModel
    @State var isPresented: Bool = false
    var body: some View {
        ZStack{
            Color.appBackground
                .ignoresSafeArea()
            VStack{
                headerView
                    .padding(.horizontal,8)
                
                if vm.showSuccesView {
                    WalletDepositView()
                        .padding(.horizontal,8)
                        .environmentObject(vm)
                } else {
                    checkoutFunds
                }
            }
            
            if vm.isLoading {
                Color.black.opacity(0.5).ignoresSafeArea()
                ProgressView()
            }
       
        }
        .onAppear{
            vm.getWalletBalance()
        }
        .paymentSheet(isPresented: $vm.presentPaymentSheet, paymentSheet: vm.paymentSheet ?? PaymentSheet(setupIntentClientSecret: "", configuration: PaymentSheet.Configuration()), onCompletion: vm.onPaymentCompletion)
    }
}

#Preview {
    CheckoutFundsView()
        .environmentObject(PaymentViewModel())
}


extension CheckoutFundsView {
    private var headerView: some View {
        HStack{
            Button{
                presented.wrappedValue.dismiss()
            } label:{
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                    .font(.title2)
                    .frame(width:44, height:44)
                    .overlay(
                    Circle()
                    .stroke(Color(red: 0.9, green: 0.9, blue: 0.92), lineWidth: 1)

                    )
                
            }
            Spacer()
            
            Text("Checkout")
                .fontWeight(.bold)
            Spacer()
            Circle()
                .frame(width: 44, height: 44)
                .opacity(0)
        }
    }
    
    private var checkoutFunds: some View {
        VStack{
            Group{
                VStack(alignment: .leading, spacing: 8){
                    
                    Text("Add Funds".localized)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                    HStack{
                        Text("Balance Top Up Amount".localized)
                        Spacer()
                        Text("AED " + vm.invest.rotate(0))
                            .foregroundColor(.black)
                        
                    }
                    .font(.system(size: 13))
                    
                }
                .modifier(CornerBackground())
                
                VStack(alignment: .leading, spacing: 8){
                    
                    Text("Payment Method".localized)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                    
                    Text("Retail investors can only use debit cards for payment".localized)
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                    PaymentCellMethod(method: .stripe)
                        .padding(.top,9)
                    PaymentCellMethod(method: .apple)
                    PaymentCellMethod(method: .crypto)
                }
                .modifier(CornerBackground())
                Spacer()
            }
            .padding(.horizontal,8)
            Spacer()
            
            
            
            Rectangle()
                .fill(Color.white)
                .ignoresSafeArea()
                .frame(height:150)
                .overlay(
                    VStack(spacing:24){
                        HStack{
                            Text("Total")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("AED " + (vm.invest.rotate(2)))
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                        
                        Button{
                            vm.addFunds()
                        } label: {
                            Text("Pay via".localized + " " + vm.paymentMethod.name.localized + " Checkout".localized)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical,14)
                                .frame(maxWidth: .infinity)
                                .backgroundColor(Color.blue)
                                .cornerRadius(14)
                        }
                        
                    }
                        .padding(.horizontal,24)
                        .padding(.top)
                        .padding(.bottom,34)
                    
                )
        }
    }
    
    
}



fileprivate struct PaymentCellMethod: View {
    @EnvironmentObject var vm: PaymentViewModel
    var method: PaymentMethod
    var body: some View {
        HStack{
            Image(systemName: vm.paymentMethod == method ? "checkmark.circle.fill" : "circle" )
                .foregroundColor(.blue)
                .onTapGesture {
                    vm.paymentMethod = method
                }
            Text(method.name)
            .font(.system(size: 15).weight(.semibold))
            .foregroundColor(.black)
            
            Spacer()
            Image(method.image ?? "")
        }
    }
}
