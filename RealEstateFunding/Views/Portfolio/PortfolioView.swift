//
//  PortfolioView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 13.09.2023.
//

import SwiftUI

struct PortfolioView: View {
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
                    
                    Image("total_invested_Image")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(32)
                        .overlay(
                            VStack(spacing: 4){
                                Text("Total invested")
                                Text("AED")
                                + Text(" 0")
                                    .font(.system(size: 28))
                            }
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                        )
                    
                    
                    portfolioValue
                    
                    listOfInvestments
                    
                    transactionsView
                    
                    annualInvestmentLimitView
                    
                    
                }
               
                
            }
            .padding(.horizontal,8)
        }
        
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}


extension PortfolioView {
    private var portfolioValue: some View {
        VStack(spacing: 24){
            VStack(spacing: 8){
                Text("Portfolio Value")
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                
                Text("AED")
                    .foregroundColor(.blue)
                    .font(.system(size: 15).weight(.semibold))
                +
                Text(" 0")
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
                            Text("AED 0")
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
                            Text("AED 0")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                        }
                    }
                }
                Spacer()
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
                ScrollView(showsIndicators: false) {
                    ForEach(1..<5, id: \.self) { _ in
                        NavigationLink{
                            InvestmentDetails()
                                .navigationBarHidden(true)
                        } label: {
                            VStack{
                                InvestmentCellView(image: "investmentCellImage", title: "1 Bed in Downtown Dubai", cost: "AED 8,230")
                                 
                                 Divider()
                                    .padding(.leading, 50)
                            }
                        }

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
            
        }
        .modifier(CornerBackground())
    }
    
    private var annualInvestmentLimitView : some View {
        VStack{
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
                    .frame(width: 10)
   
            }
            .frame(height: 5)
            HStack{
                HStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8)
                    Text("AED 0 invested")
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
    var image: String
    var title: String
    var cost: String
    var body: some View {
        HStack{
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width:40, height: 40)
            
            VStack(alignment: .leading){
                Text(title)
                    .foregroundColor(Color.gray)
                  
                Text(cost)
                    .foregroundColor(.black)
            }
            .font(.system(size: 15).weight(.semibold))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}
