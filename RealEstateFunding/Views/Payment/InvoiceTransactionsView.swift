//
//  InvoiceTransactionsView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 28.11.2023.
//

import SwiftUI
import PopupView
import Stripe
import StripePaymentSheet
import StripeApplePay


struct InvoiceTransactionsView: View {
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
                Group{
                    VStack(alignment: .leading, spacing: 8){
                        if let property = vm.propertyDetail {
                            Text(property.about ?? "")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                            HStack{
                                Text("Investment Amount")
                                Spacer()
                                Text("AED " + "\(vm.invest)")
                                    .foregroundColor(.black)
                                //                                .fontWeight(.bold)
                            }
                            .font(.system(size: 13))
                        }
                    }
                    .modifier(CornerBackground())
                    
                    VStack(alignment: .leading, spacing: 8){
                        if let cost = vm.invetsmentsCost {
                            Text("Fees")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                            HStack{
                                Text("Transaction fee (4%)")
                                Spacer()
                                Text("AED " + (cost.dldFee?.rotate(0) ?? ""))
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                            }
                            .font(.system(size: 13))
                            HStack{
                                Text("[App Name] fee (2%)")
                                Spacer()
                                Text("AED " + (cost.dubxFee?.rotate(0) ?? ""))
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                            }
                            .font(.system(size: 13))
                        }
                    }
                    .modifier(CornerBackground())
                    Spacer()
                }
                .padding(.horizontal,8)
                Spacer()
                
                
                
                Rectangle()
                    .fill(Color.white)
                    .ignoresSafeArea()
                    .frame(height:220)
                    .overlay(
                        VStack(spacing:24){
                            HStack{
                                Text("Payment Method")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16,weight: .semibold))
                                Spacer()
                                if let icon = vm.paymentMethod.image {
                                    Image(icon)
                                }
                                Button{
                                    isPresented = true
                                } label:{
                                    Image(systemName: "chevron.down")
                                }
                                
                                
                            }
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.gray, lineWidth: 0.5))
                            //                            .modifier(CornerBackground())
                            
                            HStack{
                                Text("Total")
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Text("AED " + (vm.invetsmentsCost?.investmentCost?.rotate(0) ?? "990"))
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                            }
                            
                            Button{
                                vm.createInvoice()
                            } label: {
                                Text("Pay via Stripe Checkout")
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
            if vm.invetsmentsCost == nil {
                Color.black.opacity(0.5).ignoresSafeArea()
                ProgressView()
            }
            if let paymentSheet = vm.paymentSheet {
                PaymentSheet.PaymentButton(
                    paymentSheet: paymentSheet,
                    onCompletion: vm.onPaymentCompletion
                ) {
                    Text("Buy")
                }
            }
        }
        .fullScreenCover(isPresented: $vm.showSuccesView){
            InvestedSuccesView()
                .background(Color.white)
            .environmentObject(vm)
        }
        
        .onAppear{
            if isPreview {
                vm.propertyDetail = samplePropertyDetail.data?.property
                vm.invetsmentsCost = sampleAdditionalCosts
            }
//            vm.getWalletBalance()
            vm.getTransactionsCosts(amount: Double(vm.invest))
            
            
            
            
        }
//        .onDisappear{
//            vm.cleanVMAfterPayment()
//        }
        
        .popup(isPresented: $isPresented, view: {
            SelectPaymentMethod(){
                isPresented.toggle()
            }
            .background(Color.white)
        },customize: {
            $0
                .type(.toast)
                .position(.bottom)
                .closeOnTap(false)
                .backgroundColor(.black.opacity(0.4))
        })
        
    }
}

#Preview {
    InvoiceTransactionsView()
        .environmentObject(PropertiesViewModel())
}


extension InvoiceTransactionsView {
    private var headerView: some View {
        HStack{
            Button{
                presented.wrappedValue.dismiss()
            } label:{
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                    .font(.title2)
                    .frame(width:44, height:44)
                    .background(
                        Circle().stroke(Color.black.opacity(0.5), lineWidth: 0.5)
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
    
    
}

