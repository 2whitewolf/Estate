//
//  WalletView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 27.09.2023.
//

import SwiftUI

struct WalletView: View {
    @State var hidden: Bool = true
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                    Text("Wallet")
                        .foregroundColor(.black)
                        .font(.system(size: 34).weight(.bold))
                    Spacer()
                }
                .padding(.top,50)
                .padding(.leading,22)
                
                ScrollView(showsIndicators: false) {
                    
                    balanceView
                    transactionsView
                    
                }
            }
            .padding(.horizontal,8)
        }
    }
}

#Preview {
    WalletView()
}


extension WalletView{
    private var balanceView: some View {
        VStack{
            Text("Available Balance")
                .font(.system(size: 15))
                .foregroundColor(.gray)
            
            Text("AED")
                .font(.system(size: 15))
                .foregroundColor(.blue)
            +
            Text("12,000")
                .font(.system(size: 28).weight(.bold))
                .foregroundColor(.blue)
            
            
            HStack{
                Button{
                    
                } label: {
                    Label("Add Funds", systemImage: "plus.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 17).weight(.bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(14)
                    
                }
                Button{
                    
                } label: {
                    Text("Withdraw")
                        .foregroundColor(.black)
                        .font(.system(size: 17).weight(.bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                        .cornerRadius(14)
                    
                }
            }
        }
        .modifier(CornerBackground())

    }
    
    private var transactionsView: some View {
        VStack{
            HStack{
                Text("Transactions")
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.bold))
                Spacer()
            }
            
//            VStack{
//                Image(systemName: "clock.arrow.circlepath")
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(.gray)
//                    .frame(width: 26)
//                
//                Text("No transactions yet")
//                    .font(.system(size: 15))
//                    .foregroundColor(.gray)
//            }
//            .padding(.vertical, 32)

            
            ForEach(1..<4){i in
                TransactionCellView(amount: 5518, withdraw: i % 2 == 0 )
            }
            if !hidden {
                ForEach(1..<10){i in
                    TransactionCellView(amount: 5518, withdraw: i % 2 != 0 )
                }
            }
            
            Button{
                withAnimation {
                    hidden.toggle()
                }
            } label: {
                Label("Show \(hidden ? "more" : "less")", systemImage: hidden ? "chevron.down" : "chevron.up")
                    .foregroundColor(.blue)
                    .font(.system(size: 13))
            }
        }
        .modifier(CornerBackground())
    }
}


struct TransactionCellView: View {
    var amount: Int
    var withdraw: Bool
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(withdraw ? Color(red: 0.2, green: 0.78, blue: 0.35).opacity(0.16) : Color(red: 0.95, green: 0.95, blue: 0.97))
                    .frame(width:32, height: 32)
                
                Image(systemName: withdraw ? "plus.circle.fill" : "minus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:12)
                    .foregroundColor(withdraw ? .green : .gray)
            }
            VStack(alignment: .leading,spacing: 0){
                Text("Balance \(withdraw ? "Top Up" : "Withdraw")")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                
                HStack{
                    Text("20 April")
                    Divider()
                    Text("•••• 2332")
                }
                .font(.system(size: 11))
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
            }
            
            Spacer()
            
            Text("\(withdraw ? "" : "-" ) AED \(amount)")
                .foregroundColor(withdraw ? .green : .black)
                .font(.system(size: 13).weight(.semibold))
            
        }
    }
}



