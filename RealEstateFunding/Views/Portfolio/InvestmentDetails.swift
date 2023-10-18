//
//  InvestmentDetails.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 15.09.2023.
//

import SwiftUI

struct InvestmentDetails: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack{
            headerView
            ScrollView(showsIndicators: false) {
                mainView
                
                totalInvestmentAmountView
                
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct InvestmentDetails_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentDetails()
    }
}


extension InvestmentDetails {
    private var headerView: some View {
        HStack{
            Button {
                presentation.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .padding()
                    .background(Circle().stroke(Color.gray, lineWidth: 0.5))
            }
            Spacer()
            Text("Investment details")
                .foregroundColor(.black)
                .fontWeight(.semibold)
            Spacer()
            
            Image(systemName: "arrow.left")
                .padding()
                .background(Circle().stroke(Color.gray, lineWidth: 0.5))
                .opacity(0)
        }
    }
    private var totalInvestmentAmountView: some View {
        VStack{
            Text("Total Invested amount")
                .foregroundColor(.black)
                .font(.system(size: 15).weight(.semibold))
            
            Text("AED 328")
                .foregroundColor(.blue)
                .font(.system(size: 28).weight(.bold))
            
            InvestmentCell(image: "investmentProcentImage", title: "My Ownership", secondLine: "0.3%")
            InvestmentCell(image: "money_icon", title: "Total Profit to Date", secondLine: "AED 700,391")
            InvestmentCell(image: "graphic_icon", title: "Experted profit after 1 Year", secondLine: "AED 12,391")
            
            
            Button {
                
            } label: {
                Text("Invest more")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(14)
            }
        }
        .padding(.vertical,24)
        .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 32)
            .stroke(Color.gray, lineWidth: 0.5))
    }
    
    private var mainView: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Image("investmentCellImage")
                 Text("1 Bed in Sparkle Towers, Dubai Marina")
                    .foregroundColor(.black)
                 
            }
            
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    Text("Investment Cost")
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                    
                     Spacer()
                    
                    Text("AED 734,507")
                        .font(.system(size: 17).weight(.semibold))
                        .foregroundColor(.blue)
                }
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.lightGray)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue)
                        .frame(width: 50)
                }
                .frame(height:4)
                
                investmentInfoTexts
                InvestmentDetailView()
                
                 Divider()
                    .padding(.top,24)
                
                VStack(spacing:8){
                    InvestmentPaidDetailCellView(title: "Property Value on Date of Invest...", second: "AED 1,595,518")
                    InvestmentPaidDetailCellView(title: "Property Value Today", second: "AED 1,600,000")
                    InvestmentPaidDetailCellView(title: "Annualised return", second: "From 9.98%")
                    InvestmentPaidDetailCellView(title: "Investment Period", second: "1 Year")
                }
                .padding(.top,24)
            }
            .padding(.top,18)
           
            
        }
        .modifier(CornerBackground())
    }
    
    private var investmentInfoTexts: some View {
        HStack{
            Text("48% funded")
                .padding(.vertical,4)
                .padding(.horizontal,8)
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            
            Text("AED 495,471 needed")
                .padding(.vertical,4)
                .padding(.horizontal,8)
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            
            
            Text("316 investors")
                .padding(.vertical,4)
                .padding(.horizontal,8)
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            
            
        }
        .font(.system(size: 11).weight(.medium))
        .foregroundColor(.gray)
    }
}

struct InvestmentCell: View {
    var image : String
    var title: String
    var secondLine: String
    var body: some View {
        HStack{
            Image(image)
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                Text(secondLine)
                    .font(.system(size: 17).weight(.bold))
                    .foregroundColor(.blue)
            }
            Spacer()
        }
    }
}


private struct InvestmentDetailView: View {
    @State var show: Bool = false
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text("Investment Details")
                    .font(.system(size: 13).weight(.bold))
                Spacer()
                Button {
                    withAnimation {
                        show.toggle()
                    }
                } label: {
                    Image(systemName:  show ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                        .background(Color.clear)
                }
            }
            .foregroundColor(.blue)
            if show {
                VStack(spacing:12) {
                    InvestmentDetailCellView(title: "Property Price", count: "1,595,518")
                    InvestmentDetailCellView(title: "Investment needed (62%)", count: "638,702.20")
                    InvestmentDetailCellView(title: "Transaction fee (4%)", count: "63,870.22")
                    InvestmentDetailCellView(title: "[App Name] fee (2%)", count: "31,510.48")
                    InvestmentDetailCellView(title: "Investment cost", count: "734,507")
                }
                .padding(.top,24)
            }
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 12)
            .stroke(Color.gray, lineWidth: 0.5))
    }
}


private struct InvestmentDetailCellView : View {
    var title: String
    var count: String
    var body: some View{
        HStack{
            Text(title)
                .foregroundColor(.black)
             Spacer()
            Text("AED" + count)
                .foregroundColor(.black)
                .fontWeight(.semibold)
        }
        .font(.system(size: 13))
    }
}


private struct InvestmentPaidDetailCellView: View {
    var title: String
    var second: String
    var body: some View{
        HStack(spacing: 5){
            Text(title)
                .lineLimit(1)
                .foregroundColor(.black)
             Spacer()
            Text(second)
                .foregroundColor(.blue)
                .fontWeight(.semibold)
            Image(systemName: "info.circle")
                .foregroundColor(.gray)
        }
        .font(.system(size: 13))
    }
}
