//
//  WalletView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 27.09.2023.
//

import SwiftUI
import PopupView

struct WalletView: View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var vm: WalletViewModel = WalletViewModel()
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                    Text("Wallet".localized)
                        .foregroundColor(.black)
                        .font(.system(size: 34).weight(.bold))
                    Spacer()
                }
                .padding(.top,50)
                .padding(.leading,22)
                if  let account = vm.accountInfo {
                    ScrollView(showsIndicators: false) {
                        
                        balanceView
                        transactionsView
                        
                    }
                } else {
                    ProgressView()
                        .padding(.top,UIScreen.screenHeight * 0.3)
                }
                 Spacer()
            }
            .padding(.horizontal,8)
            if vm.presentAddingFunds {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
            }
        }
        .popup(isPresented:  $vm.presentAddingFunds) {
            AddFundsView(vm: vm.getPaymentViewModel()){
                           vm.presentAddingFunds.toggle()
                       }
        } customize: {
            $0
                .type(.toast)
                .position(.bottom)
                .closeOnTap(false)
                .backgroundColor(.black.opacity(0.4))
        }
        .onAppear{
            if vm.appViewModel == nil {
                vm.appViewModel = appVM
            }
                vm.getAccountInfo()
        }
    }
}

#Preview {
    WalletView()
        .environmentObject(AppViewModel())
}


extension WalletView{
    private var balanceView: some View {
        VStack{
            Text("Available Balance".localized)
                .font(.system(size: 15))
                .foregroundColor(.gray)
            if let accountInfo = vm.accountInfo {
                
                Text("AED ")
                    .font(.system(size: 15))
                    .foregroundColor(.blue)
                +
                Text(accountInfo.balance ?? "0")
                    .font(.system(size: 28).weight(.bold))
                    .foregroundColor(.blue)
            }
            
            
            HStack{
                Button{
                    vm.presentAddingFunds = true
                } label: {
                    Label("Add Funds".localized, systemImage: "plus.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 17).weight(.bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(14)
                    
                }
                Button{
                    
                } label: {
                    Text("Withdraw".localized)
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
                Text("Transactions".localized)
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.bold))
                Spacer()
            }
            if vm.transactionsList.wrappedValue.isEmpty {
                VStack{
                    Image(systemName: "clock.arrow.circlepath")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 26)
                    
                    Text("No transactions yet".localized)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 32)
            } else {
                VStack{
                    ForEach(vm.transactionsList.wrappedValue, id: \.self){ transaction in
                        TransactionCellView(transaction: transaction)
                    }
                    if vm.transactionsList.wrappedValue .count > 3 {
                        ShowMoreLessButton(tapped: $vm.hidden)
                    }
                }
            }
        }
        .modifier(CornerBackground())
    }
}


struct TransactionCellView: View {
    var transaction: Transaction
    var withdraw: Bool
    
    init(transaction: Transaction) {
        self.transaction = transaction
        self.withdraw = transaction.type != "investment"
    }
    //    var amount: Int
    //    var withdraw: Bool
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
                Text("Balance".localized +  " \(withdraw ? "Top Up".localized : "Withdraw".localized)")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                
                HStack{
                    Text(transaction.createdAt ?? "")
                }
                .font(.system(size: 11))
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
            }
            
            Spacer()
            
            Text("\(withdraw ? "+" : "-" ) AED " + (transaction.amount?.toDouble().rotate(0) ?? "0"))
                .foregroundColor(withdraw ? .green : .black)
                .font(.system(size: 13).weight(.semibold))
            
        }
    }
}



