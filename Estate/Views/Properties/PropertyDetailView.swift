//
//  PropertyinfoView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 19.09.2023.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct PropertyDetailView: View {
    @Environment(\.presentationMode) var presentation
    
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var vm: PropertiesViewModel
    
    @State private var scrollOffset: CGPoint = .zero
    
    @State var property: Property
    @State var opacity: Double = 0
    @State var offset: Double = -200
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.white.ignoresSafeArea()
            VStack{
                
                //               headerView
                ZStack(alignment: .top){
                    ScrollViewWithOffset(onScroll: handleScroll) {
                        //                ScrollView(showsIndicators: false) {
                        ScrollViewReader { value in
                            
                            LazyVStack {
                                ZStack(alignment: .top){
                                    if let property = vm.propertyDetail {
                                        PropertyImageView(images: property.images ?? [] , alignment: .bottom)
                                            .frame(maxWidth: .infinity)
                                            .cornerRadius(52)
                                            .padding(.top,8)
                                        
                                    }
                                    
                                    headerView
                                }
                                .id(1)
                                
                                propertyPriceView
                                
                                propertyDescription
                                
                                InvestmentCalculatorView()
                                
                                FinancialsView()
                                
                                if let property = vm.propertyDetail {
                                    PropertyLocationView(coordinate: CLLocationCoordinate2D(latitude: property.coordinateX?.toDouble() ?? 0 , longitude: property.coordinateY?.toDouble() ?? 0))
                                }
                                
                                aboutPropertyView
                                
                                similars(value: value)
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .padding(.horizontal,8)
                    
                    smallHeaderView
                       .opacity(opacity)
                       .offset(y: offset)
                       .animation(.linear)
                }
            }
           
            
            
            
            bottomButton
            
            loading
            
            
        }
        .ignoresSafeArea()
        .onAppear{
            vm.getPropertyDetail(property: property)
        }
        .onDisappear(perform: {
            SDImageCache().clearMemory()
        })
        
    }
    
    
}


extension PropertyDetailView{
    
    private func  similars(value:ScrollViewProxy) -> some View {
        VStack{
            HStack{
                Text("Similar properties".localized)
                    .font(.system(size: 20).weight(.semibold))
                    .foregroundColor(.black)
                Spacer()
            }
            if let  similars = vm.similar {
                VStack(spacing: 10) {
                    ForEach(similars, id: \.id) { property in
                        PropertyCellView(property: property)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    vm.addPropertyToHistory(property:property)
                                    value.scrollTo(1)
                                }
                            }
                    }
                    
                }
                .padding(.bottom,105)
            }
        }
    }
    
    private var loading: some View {
        Group{
            if vm.isLoading{
                Color.black.opacity(0.4)
                ProgressView()
            }
        }
    }
    
    private var bottomButton: some View {
        VStack{
            Divider()
            NavigationLink{
                InvestView(vm: vm.createPaymentViewModel())
                
                    .navigationBarHidden(true)
                
            } label: {
                Text("Invest".localized)
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
    
    private var investmentInfoTexts: some View {
        HStack{
            if let property = vm.propertyDetail {
                
                Text((property.funded?.rotate(0) ?? "0") + "% " + "funded".localized)
                    .padding(.vertical,4)
                    .padding(.horizontal,8)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.5))
                
                Text("AED " + (property.needed?.rotate(0) ?? "0")  + " " + "needed".localized)
                    .padding(.vertical,4)
                    .padding(.horizontal,8)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.5))
                
                
                Text((property.investors?.rotate(0) ?? "0") + " " + "investors".localized)
                    .padding(.vertical,4)
                    .padding(.horizontal,8)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.5))
            }
            
        }
        .font(.system(size: 11).weight(.medium))
        .foregroundColor(.gray)
        
    }
    
    private var propertyPriceView: some View {
        VStack(spacing: 8){
            if let property = vm.propertyDetail {
                Text("Property Price".localized)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                
                Text("AED")
                    .font(.system(size: 15).weight(.semibold))
                    .foregroundColor(.blue)
                + Text(property.totalPrice?.rotate(1) ?? "")
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
                            Text("Annualised return".localized)
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                            Text((property.annualProfit ?? "") + "%")
                                .foregroundColor(.blue)
                                .font(.system(size: 17).weight(.semibold))
                        }
                    }
                    Spacer()
                    HStack{
                        Image("calendar_withBack")
                        VStack(alignment: .leading){
                            Text("Investment Periiod".localized)
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                            Text((property.period ?? "") + " " + "Year".localized)
                                .foregroundColor(.blue)
                                .font(.system(size: 17).weight(.semibold))
                        }
                    }
                }
            }
        }
        .modifier(CornerBackground())
    }
    
    private var propertyDescription: some View {
        VStack(alignment: .leading){
            if let property = vm.propertyDetail {
                Text("\(property.bed ?? 0) " + "Bed in".localized + " " + (property.location ?? ""))
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                tegsView
                
                infoProfits
            }
        }
        .modifier(CornerBackground())
    }
    
    private var tegsView: some View {
        HStack(spacing: 8){
            if let property = vm.propertyDetail {
                HStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8)
                    Text(property.type ?? "")
                        .font(.system(size: 11))
                        .foregroundColor(.black)
                }
                .frame(height:21)
                .padding(.horizontal,8)
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                .cornerRadius(12)
                
                HStack{
                    Image(systemName: "bed.double.fill")
                        .foregroundColor(Color(red: 0.35, green: 0.34, blue: 0.84))
                    Text("\(property.bed ?? 0) Bed")
                        .font(.system(size: 11))
                        .foregroundColor(.black)
                }
                .frame(height:21)
                .padding(.horizontal,8)
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                .cornerRadius(12)
                
                HStack{
                    Image("size")
                        .foregroundColor(Color(red: 0.35, green: 0.34, blue: 0.84))
                    Text("\(property.meter ?? 0) sq.ft")
                        .font(.system(size: 11))
                        .foregroundColor(.black)
                }
                .frame(height:21)
                .padding(.horizontal,8)
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
                .cornerRadius(12)
            }
        }
    }
    //MARK: need to change to data from api
    private var infoProfits: some View {
        VStack(alignment: .leading){
            if let property = vm.propertyDetail {
                PropertyInfoDetailCellView(flag: "AE", title: property.location ?? "", message: "An upscale community in the heart of the city. Home to the Burj Khalifa and Dubai Mall")
                
                PropertyInfoDetailCellView(image:Image("cup_image"), title: "Big Profits".localized, message: "Off-Plan investing is the best way to make big profits".localized)
                
                PropertyInfoDetailCellView(image: Image("shield_image"), title: "Safe Investing".localized, message: "Safe investing regulated by the DFSA".localized)
                PropertyInfoDetailCellView(image: Image("graphic_image"), title: "10% Growth".localized, message: "At least 10% growth".localized)
            }
        }
    }
    
    
    //MARK: Need to check texts
    private var aboutPropertyView: some View {
        VStack(alignment:.leading, spacing: 8){
            if let property = vm.propertyDetail {
                Text("About the property".localized)
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                
                Text("This apartment is offered at a price of AED".localized + "1,595,518" + ", with a projected gross yield of 7.52% in the first year, and after deducting all expected running costs, the property offers its investors a projected net yield of 6.00% in the first year.")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
                Text("show more".localized)
                    .font(.system(size: 15))
                    .foregroundColor(.blue)
                
                
                Text("Seller".localized)
                    .font(.system(size: 17).weight(.semibold))
                    .foregroundColor(.black)
                    .padding(.top,8)
                
                Text("SellerName")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
                Text("Developer".localized)
                    .font(.system(size: 17).weight(.semibold))
                    .foregroundColor(.black)
                    .padding(.top,8)
                
                Text(property.developerSpecsSubtitle ?? "")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
            }
        }
        .modifier(CornerBackground())
    }
    
    private var headerView: some View {
        HStack{
            Button {
                
                if vm.backButtonTapped(){
                    presentation.wrappedValue.dismiss()
                }
                //                vm.backToPreviously()
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .padding(12)
                    .background(
                        Circle().fill(Color.black.opacity(0.5))
                    )
            }
            Spacer()
            
            Button {
                vm.favoriteButtonPressed(property: property)
                property.favorite?.toggle()
            } label: {
                Image(systemName: "\(property.favorite ?? false ?  "heart.fill" : "heart")")
                    .foregroundColor(.white)
                    .padding(12)
                    .background(
                        Circle().fill(Color.black.opacity(0.5))
                    )
            }
            
        }
        .padding(.top,55)
        .padding(.horizontal)
    }
    
    private var smallHeaderView: some View {
        HStack{
            Button {
                
                if vm.backButtonTapped(){
                    presentation.wrappedValue.dismiss()
                }
                //                vm.backToPreviously()
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
                    .padding(12)
                    .background(
                        Circle().fill(Color.white)
                    )
            }
            Spacer()
            
            Button {
                vm.favoriteButtonPressed(property: property)
                property.favorite?.toggle()
            } label: {
                Image(systemName: "\(property.favorite ?? false ?  "heart.fill" : "heart")")
                    .foregroundColor(.blue)
                    .padding(12)
                    .background(
                        Circle().fill(Color.white.opacity(0.5))
                    )
            }
            
        }
        .padding(.top,55)
        
        .padding(.horizontal,24)
        .background(Color.white)
    }
    
    
    func handleScroll(_ offset: CGPoint) {
        self.scrollOffset = offset
        switch offset.y{
        case 0...10 :
            self.opacity = 0
            self.offset = -100
        case  10...20:
            self.offset = -50
            self.opacity = 0.5
        case 20 ... 50:
            self.offset = 0
            self.opacity = 1
            
        default:
            self.offset =  0
            self.opacity = 1
        }
        print("Offset \(offset)")
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
                    .foregroundColor(.black)
                Text(message)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
    }
}



#Preview{
    PropertyDetailView(property: sampleProp)
        .environmentObject(PropertiesViewModel())
}
