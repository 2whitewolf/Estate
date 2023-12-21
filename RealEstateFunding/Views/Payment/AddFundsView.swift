//
//  AddFundsView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 19.12.2023.
//

import SwiftUI

struct AddFundsView: View {
    @StateObject var vm : PaymentViewModel
    var onClose: () -> Void
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "xmark.circle.fill")
                    .opacity(0)
                Spacer()
                Text("Add Funds")
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
                Text("Add Funds")
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                HStack{
                    TextField("", value: $vm.invest, formatter: formatter)
                        .keyboardType(.numberPad)
                        .foregroundColor( vm.amountWrong ? Color.red : .black)
                        .font(.system(size: 16))
                    
                    Text("AED")
                        .font(.system( size: 16).weight(.semibold))
                        .foregroundColor( Color(red: 0.68, green: 0.68, blue: 0.7))
                    
                }
                .padding(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                    .inset(by: 0.5)
                    .stroke( vm.amountWrong ? Color.red :  Color(red: 0.82, green: 0.82, blue: 0.84), lineWidth: 1)
                )
               
                Text("Minimum amount is 500 AED")
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.8))
                
                NavigationLink{
                 CheckoutFundsView()
                        .environmentObject(vm)
                        .navigationBarHidden(true)
                        .onDisappear{
                            onClose()
                        }
                } label: {
                    Text("Chose Payment Method")
                        .foregroundColor(.white)
                        .font(.system(size: 17).weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height:50)
                        .background( vm.amountWrong ? Color.gray : Color.blue)
                        .cornerRadius(14)
                        
                }
                .disabled(vm.amountWrong)
               
            }
            .modifier(CornerBackground())

          Spacer()
        }
        .padding(.horizontal,8)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.top,60)

    }
}

#Preview {
    AddFundsView(vm: PaymentViewModel(),onClose: {})

}
