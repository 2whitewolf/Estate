//
//  PortfolioView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 13.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PortfolioView: View {
    @StateObject var vm: PortfolioViewModel = PortfolioViewModel()
    @EnvironmentObject var appVM: AppViewModel
  
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                ScrollView(showsIndicators: false){
                    HStack{
                        Text("Portfolio")
                            .font(.system(size: 34).weight(.bold))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal,22)
                    .padding(.top,50)
                    
                  
                    
                    if  let investment = vm.investments {
                        totalInvested
                        portfolioValue
                        
                        listOfInvestments
                    } 
//                    else {
//                        ProgressView()
//                            .padding(.top,UIScreen.screenHeight * 0.3)
//                    }
                    
                  
                    
//                    transactionsView
                    
//                    annualInvestmentLimitView
                    
                    
                }
                
                
            }
            .padding(.horizontal,8)
            
            if vm.isLoading {
                ProgressView()
                   
            }
        }
        .onAppear{
            if vm.appViewModel == nil {
                vm.appViewModel = appVM
            }
//            if let user = appVM.user {
                vm.getPortfolioData()
//            }
        }
        
    }
}


#Preview{
    PortfolioView()
        .environmentObject(AppViewModel())
}



extension PortfolioView {
    
    private var totalInvested: some View {
        Image("total_invested_Image")
            .resizable()
            .scaledToFit()
            .cornerRadius(32)
            .overlay(
                VStack(spacing: 4){
                    Text("Total invested")
                    Text("AED")
                    + Text(vm.investments?.totalInvested.rotate(0) ?? "0")
                        .font(.system(size: 28))
                }
                    .foregroundColor(.white)
                    .font(.system(size: 15))
            )
    }
    private var portfolioValue: some View {
       
        VStack(spacing: 24){
            if let invested = vm.investments {
                VStack(spacing: 8){
                    Text("Portfolio Value")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                    
                    Text("AED ")
                        .foregroundColor(.blue)
                        .font(.system(size: 15).weight(.semibold))
                    +
                    Text(invested.totalInvested.rotate(0))
                        .foregroundColor(.blue)
                        .font(.system(size: 28).weight(.bold))
                }
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            Image( "money_icon")
                            VStack(alignment: .leading){
                                Text("Total Profit to Date")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                                Text("AED " + invested.totalProfitToDate.rotate(0))
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                            }
                        }
                        HStack{
                            Image( "graphic_icon")
                            VStack(alignment: .leading){
                                Text("Expected Profit after 1 Year")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                                Text("AED " + invested.expectedProfitAfterYear.rotate(0))
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .modifier(CornerBackground())
        
    }
    
    private var listOfInvestments: some View {
        VStack(spacing: 16){
            HStack{
                Text("List of Investments")
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                Spacer()
            }
            VStack{
                if !(vm.investmentsList.wrappedValue.isEmpty ?? false)  {
                    
                    ScrollView(showsIndicators: false) {
                        ForEach( vm.investmentsList.wrappedValue, id: \.id) { investment in
                            NavigationLink{
                                InvestmentDetails(investment: investment)
                                    .navigationBarHidden(true)
                                    .environmentObject(vm)
                                    .environmentObject(appVM)
                            } label: {
                                VStack{
                                    InvestmentCellView(investment: investment)
                                    
                                    Divider()
                                        .padding(.leading, 50)
                                }
                            }
                            
                        }
                    }
                    if vm.investmentsList.wrappedValue.count > 4 {
                        ShowMoreLessButton(tapped: $vm.investmentsListOpened)
                    }
                  
                } else {
                   
                    Image(systemName: "clock.arrow.circlepath")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 26)
                    
                    Text("No investments yet")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                   
                }
            }
        }
        .modifier(CornerBackground())
    }
    
    private var transactionsView : some View {
        VStack{
            HStack{
                Text("Transactions")
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                Spacer()
            }
            Image(systemName: "clock.arrow.circlepath")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .frame(width: 26)
            
            Text("No transactions yet")
                .font(.system(size: 15))
                .foregroundColor(.gray)
            
            ShowMoreLessButton(tapped: $vm.transactionsListOpened)
                .hidden()
        }
        .modifier(CornerBackground())
    }
    
    private var annualInvestmentLimitView : some View {
        VStack{
            if let invested = vm.investments {
                HStack{
                    Text("Annual Investment Limit")
                        .foregroundColor(.black)
                        .font(.system(size: 20).weight(.semibold))
                    Spacer()
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                }
                
                ZStack(alignment: .leading) {
                    Rectangle().fill(Color.lightGray)
                        .frame(maxWidth: .infinity)
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(maxWidth: .infinity)
                    
                }
                .frame(height: 5)
                HStack{
                    HStack{
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 8)
                        Text("AED " + invested.totalInvested.rotate(0) + " invested")
                            .font(.system(size: 11).weight(.medium))
                            .foregroundColor(.gray)
                    }
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.5))
                    
                    
                    HStack{
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 8)
                        Text("AED 0 available")
                            .font(.system(size: 11).weight(.medium))
                            .foregroundColor(.gray)
                    }
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.5))
                    
                    
                }
                
            }
            
            
            Button {
                
            } label: {
                Text("Invest Now")
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.lightBlue)
                    .cornerRadius(14)
            }
            
        }
        .modifier(CornerBackground())
    }
}


struct InvestmentCellView : View {
    var investment: Investment
    var body: some View {
        HStack{
                if let url = URL(string: "https://afehe-hwf.buzz/storage/" + (investment.images.first?.path ?? "")) {
                    WebImage(url: url)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .cornerRadius(12)
                }
            
            VStack(alignment: .leading){
                Text(investment.name)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
                
                Text("AED " + investment.invested.rotate(0))
                    .foregroundColor(.black)
            }
            .font(.system(size: 15).weight(.semibold))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}
