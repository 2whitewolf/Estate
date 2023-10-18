//
//  PropertyinfoView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 19.09.2023.
//

import SwiftUI
import MapKit

struct PropertyDetailView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        ZStack(alignment: .bottom){
            Color.white.ignoresSafeArea()
            VStack{
                ScrollView(showsIndicators: false) {
                    ZStack(alignment: .top){
                        Image("propertyDetailImage")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(52)
                            .padding(.top,8)
//                            .ignoresSafeArea()
                        
                        
                        HStack{
                            Button {
                                presentation.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .background(
                                        Circle().fill(Color.black.opacity(0.5))
                                    )
                            }
                            Spacer()
                            Image(systemName: "bookmark.fill")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(
                                    Circle().fill(Color.black.opacity(0.5))
                                )
                            
                            Image(systemName: "arkit")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(
                                    Circle().fill(Color.black.opacity(0.5))
                                )
                            
                            
                        }
                        .padding(.top,55)
                        .padding(.horizontal)
                    }
                    
                    propertyPriceView
                    
                    propertyDescription
                    
                    InvestmentCalculatorView()
                    
                     FinancialsView()
                    
                    
                    PropertyLocationView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166868))
                    
                    aboutPropertyView
                    
                    HStack{
                        Text("Similar properties")
                            .font(.system(size: 20).weight(.semibold))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    
                    PropertyCellView(image: "")
                    PropertyCellView(image: "")
                        .padding(.bottom,105)
                }
                .ignoresSafeArea()
            }
            .padding(.horizontal,8)
            
            
            
            VStack{
                 Divider()
                Button{
                    
                } label: {
                    Text("Invest")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .backgroundColor(.blue)
                        .cornerRadius(12)
                    
                }
                .ignoresSafeArea()
                .padding(8)
                .padding(.bottom,30)
                .padding(.horizontal)
              
                
            }
            .background(Color.white)
            .ignoresSafeArea()

           
        }
        .ignoresSafeArea()
    }
}

struct PropertyinfoView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyDetailView()
    }
}

extension PropertyDetailView{
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
    
    private var propertyPriceView: some View {
        VStack(spacing: 8){
            Text("Property Price")
                .foregroundColor(.gray)
                .font(.system(size: 15))
            
             Text("AED")
                .font(.system(size: 15).weight(.semibold))
                .foregroundColor(.blue)
            + Text("1,595,518")
                .foregroundColor(.blue)
                .font(.system(size: 28).weight(.bold))
            
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.lightGray)
                 RoundedRectangle(cornerRadius: 4)
                    .fill(Color.blue)
                    .frame(width: 50)
            }
            .frame(height: 4)
            investmentInfoTexts
            HStack{
                HStack{
                    Image("graphic_icon")
                    VStack(alignment: .leading){
                        Text("Annualised return")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                         Text("10.98%")
                            .foregroundColor(.blue)
                            .font(.system(size: 17).weight(.semibold))
                    }
                }
                 Spacer()
                HStack{
                    Image("calendar_withBack")
                    VStack(alignment: .leading){
                        Text("Investment Periiod")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                         Text("1 Year")
                            .foregroundColor(.blue)
                            .font(.system(size: 17).weight(.semibold))
                    }
                }
            }
        }
        .modifier(CornerBackground())
    }
    
    private var propertyDescription: some View {
        VStack(alignment: .leading){
            Text("1 Bed in Old Town Downtown Dubai")
                .foregroundColor(.black)
                .font(.system(size: 20).weight(.semibold))
            tegsView
            
            infoProfits

        }
        .modifier(CornerBackground())
    }
    
    private var tegsView: some View {
        HStack(spacing: 8){
            HStack{
                Circle()
                    .fill(Color.blue)
                    .frame(width: 8)
                 Text("New")
                    .font(.system(size: 11))
            }
            .frame(height:21)
            .padding(.horizontal,8)
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            .cornerRadius(12)
            
            
            HStack{
                Text("AE".countryFlag)
                 Text("Dubai")
                    .font(.system(size: 11))
            }
            .frame(height:21)
            .padding(.horizontal,8)
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            .cornerRadius(12)
            
            HStack{
                Image(systemName: "bed.double.fill")
                    .foregroundColor(Color(red: 0.35, green: 0.34, blue: 0.84))
                 Text("1 Bed")
                    .font(.system(size: 11))
            }
            .frame(height:21)
            .padding(.horizontal,8)
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            .cornerRadius(12)
            
            HStack{
                Image("size")
                    .foregroundColor(Color(red: 0.35, green: 0.34, blue: 0.84))
                 Text("182 sq.ft")
                    .font(.system(size: 11))
            }
            .frame(height:21)
            .padding(.horizontal,8)
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            .cornerRadius(12)
            Spacer()
            
        }
    }
    
    private var infoProfits: some View {
        VStack(alignment: .leading){
            PropertyInfoDetailCellView(flag: "AE", title: "Downtown Dubai, Dubai", message: "An upscale community in the heart of the city. Home to the Buri Khalifa and Dubai Mall")
            
            PropertyInfoDetailCellView(image:Image("cup_image"), title: "Big Profits", message: "Off-Plan investing is the best way to make big profits")
            
            PropertyInfoDetailCellView(image: Image("shield_image"), title: "Safe Investing", message: "Safe investing regulated by the DFSA")
            PropertyInfoDetailCellView(image: Image("graphic_image"), title: "10% Growth", message: "At least 10% growth ")
        }
    }
    
    private var aboutPropertyView: some View {
        VStack(alignment:.leading, spacing: 8){
            Text("About the property")
                .foregroundColor(.black)
                .font(.system(size: 20).weight(.semibold))
            
            Text("This apartment is offered at a price of AED 1,595,518, with a projected gross yield of 7.52% in the first year, and after deducting all expected running costs, the property offers its investors a projected net yield of 6.00% in the first year.")
                .font(.system(size: 15))
                .foregroundColor(.black)
            
            Text("show more")
                .font(.system(size: 15))
                .foregroundColor(.blue)
            
            
            Text("Seller")
                .font(.system(size: 17).weight(.semibold))
                .foregroundColor(.black)
                .padding(.top,8)
            
            Text("Sellername")
                .font(.system(size: 15))
                .foregroundColor(.black)
            
            Text("Seller")
                .font(.system(size: 17).weight(.semibold))
                .foregroundColor(.black)
                .padding(.top,8)
            
            Text("Sellername")
                .font(.system(size: 15))
                .foregroundColor(.black)
            
            
            
        }
        .modifier(CornerBackground())
    }
    
}


private struct PropertyInfoDetailCellView: View {
    var image: Image?
    var flag: String?
    var title: String
    var message: String
    
    var body: some View{
        HStack(alignment: .top){
            if let flag = flag {
                Text(flag.countryFlag)
            }
           
            if let image = image {
               image
            }
            
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(size: 15).weight(.semibold))
                Text(message)
                   .multilineTextAlignment(.leading)
                   .font(.system(size: 13))
                   .foregroundColor(.gray)
//                   .padding(.trailing)
            }
        }
    }
}
