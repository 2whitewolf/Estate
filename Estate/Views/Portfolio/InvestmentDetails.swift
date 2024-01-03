//
//  InvestmentDetails.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 15.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct InvestmentDetails: View {
    @EnvironmentObject var vm: PortfolioViewModel
//    @EnvironmentObject var appVM: AppViewModel
    @Environment(\.presentationMode) var presentation
    var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    var investment: Investment
    var body: some View {
        ZStack{
            VStack{
                headerView
                ScrollView(showsIndicators: false) {
                    mainView
                    
                    totalInvestmentAmountView
                    
                }
                Spacer()
            }
            .padding(.horizontal)
            if vm.isLoading {
                ProgressView()
            }
        }
        .onAppear{
                vm.getInvestmentDetailData( propertyId: investment.id)
        }
    }
}

struct InvestmentDetails_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentDetails( investment: sampleInvestment)
//            .environmentObject(AppViewModel())
            .environmentObject(PortfolioViewModel())
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
            if let investmentDetail = vm.investmentDetail {
                Text("Total Invested amount")
                    .foregroundColor(.black)
                    .font(.system(size: 15).weight(.semibold))
                
                Text("AED " + investmentDetail.totalInvestedAmount)
                    .foregroundColor(.blue)
                    .font(.system(size: 28).weight(.bold))
                
                InvestmentCell(image: "investmentProcentImage", title: "My Ownership", secondLine: "\(investmentDetail.userOwnership) %")
                InvestmentCell(image: "money_icon", title: "Total Profit to Date", secondLine: "AED \(investmentDetail.totalProfitToDate)")
                InvestmentCell(image: "graphic_icon", title: "Experted profit after 1 Year", secondLine: "AED \(investmentDetail.expectedProfitAfterYear)")
                
            }
            NavigationLink {
                InvestView(vm: vm.getPaymentViewModel(id: self.investment.id))
                    .navigationBarHidden(true)
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
                if let url = URL(string: "https://afehe-hwf.buzz/storage/" + (investment.images.first?.path ?? "")) {
                    WebImage(url: url)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .cornerRadius(12)
                }
                Text(investment.name)
                    .foregroundColor(.black)
                
            }
            
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    Text("Investment Cost")
                        .font(.system(size: 13))
                        .foregroundColor(.black)
                    
                    Spacer()
                    //MARK: transactions cost
                    if let investmentDetail = vm.investmentDetail {
                        Text("AED \(investmentDetail.financial.transactionCosts)")
                            .font(.system(size: 17).weight(.semibold))
                            .foregroundColor(.blue)
                    }
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
                if let investmentDetail = vm.investmentDetail {
                    VStack(spacing:8){
                        InvestmentPaidDetailCellView(title: "Property Value on Date of Invest...", second: "AED " + investmentDetail.propertyValueOnDateOfInvest.rotate(0))
                        InvestmentPaidDetailCellView(title: "Property Value Today", second: "AED " + investmentDetail.propertyValueToday.rotate(0))
                        InvestmentPaidDetailCellView(title: "Annualised return", second: "From " + investmentDetail.annualisedReturn)
                        InvestmentPaidDetailCellView(title: "Investment Period", second: investmentDetail.investmentPeriod + " Year\(investmentDetail.investmentPeriod.count > 1 ? "s" : "")")
                    }
                    .padding(.top,24)
                }
            }
            .padding(.top,18)
            
            
        }
        .modifier(CornerBackground())
    }
    
    private var investmentInfoTexts: some View {
        
        HStack{
            if let investmentDetail = vm.investmentDetail {
                Text(investmentDetail.funded.rotate(2) + "% funded")
                    .padding(.vertical,4)
                    .padding(.horizontal,8)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.5))
                
                Text("AED " + investmentDetail.investmentNeeded.rotate(0) + " needed")
                    .padding(.vertical,4)
                    .padding(.horizontal,8)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.5))
                
                
                Text("\(investmentDetail.investors) investors")
                    .padding(.vertical,4)
                    .padding(.horizontal,8)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.5))
                
            }
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
    @EnvironmentObject var vm: PortfolioViewModel
    @State var show: Bool = false
    var body: some View {
        VStack(spacing: 0){
            if let investmentDetail = vm.investmentDetail {
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
                        InvestmentDetailCellView(title: "Property Price", count: investmentDetail.propertyValueToday.rotate(0))
                        InvestmentDetailCellView(title: "Investment needed (62%)", count: investmentDetail.investmentNeeded.rotate(0))
                        InvestmentDetailCellView(title: "Transaction fee (4%)", count: investmentDetail.financial.dldFee.rotate(0))
                        InvestmentDetailCellView(title: "[App Name] fee (2%)", count: investmentDetail.financial.dubxFee.rotate(0))
                        InvestmentDetailCellView(title: "Investment cost", count: investmentDetail.financial.investmentCost.rotate(0))
                    }
                    .padding(.top,24)
                }
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
            Text("AED " + count)
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
