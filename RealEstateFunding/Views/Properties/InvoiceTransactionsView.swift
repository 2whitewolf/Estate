//
//  InvoiceTransactionsView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 28.11.2023.
//

import SwiftUI

struct InvoiceTransactionsView: View {
    @Environment(\.presentationMode) var presented
    @EnvironmentObject var appVM: AppViewModel
    @EnvironmentObject var vm: PropertiesViewModel
    var invest: Int
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
                                Text("AED 500")
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
                                Text("AED " + cost.dldFee.rotate(0))
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                            }
                            .font(.system(size: 13))
                            HStack{
                                Text("[App Name] fee (2%)")
                                Spacer()
                                Text("AED " + cost.dubxFee.rotate(0))
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
                            DisclosureGroup(
                                content: { /*@START_MENU_TOKEN@*/Text("Content")/*@END_MENU_TOKEN@*/ },
                                label: { Text("Payment Method")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16,weight: .semibold))
                                }
                            )
                            .accentColor(.black)
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.gray, lineWidth: 0.5))
//                            .modifier(CornerBackground())

                            HStack{
                                Text("Total")
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                   
                                 Spacer()
                                
                                Text("AED " + (vm.invetsmentsCost?.investmentCost.rotate(0) ?? "990"))
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                            }
                            Button{
                                
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
                Color.black.opacity(0.5)
                ProgressView()
            }
        }
        .onAppear{
            if let user = appVM.user,let  property = vm.propertyDetail {
                vm.getTransactionsCosts(userId: user.id , amount: Double(invest))
            }
            if isPreview {
                vm.propertyDetail = samplePropertyDetail.data?.property
                vm.invetsmentsCost = sampleAdditionalCosts
            }
        }
    }
}

#Preview {
    InvoiceTransactionsView(invest: 200)
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

