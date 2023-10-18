//
//  PropertiesList.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI

struct PropertiesList: View {
//    @StateObject var vm: PropertiesViewModel = PropertiesViewModel()
    var body: some View {
        ZStack{
            VStack(spacing: 0){
               headerView
               titleView
                    .padding(.top,6)
                ScrollView(showsIndicators: false) {
                    ForEach(1..<4, id: \.self) { _ in
                        NavigationLink{
//                            InvestmentDetails()
                            PropertyDetailView()
                                .navigationBarHidden(true)
                        } label: {
                            PropertyCellView(image: "")
                        }
                        
                    }
                    
                }
                .padding(.top,23)
                
             
                Spacer()
            }
            .padding(.horizontal)
        }
//        .onAppear{
//            vm.getAllProperties()
//        }
    }
}

struct PropertiesList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PropertiesList()
        }
    }
}


extension PropertiesList {
    private var headerView: some View {
        HStack{
            Spacer()
            
            NavigationLink{
                FavouritesView()
                    .navigationBarHidden(true)
            } label: {
                Image(systemName: "bookmark")
                    .font(.system(size: 20))
                    .frame(width: 44, height: 44)
                    .background(Circle().stroke(Color.gray, lineWidth: 0.5))
            }
            NavigationLink{
                 NotificationsListView()
                    .navigationBarHidden(true)
            } label: {
                Image(systemName: "bell")
                    .font(.system(size: 20))
//                    .foregroundColor(.blue)
                   
                    .frame(width: 44, height: 44)
                    .background(Circle().stroke(Color.gray, lineWidth: 0.5))
            }
            
        }
        .foregroundColor(.blue)
    }
    
    private var titleView : some View {
        HStack{
             Text("Properties")
                .font(.system(size: 34).weight(.bold))
          Spacer()
        }
        .padding(.leading)
    }
}


struct PropertyCellView: View {
    var image: String
    var body: some View {
        ZStack{
           Image("propertyBackImage")
                .resizable()
                .scaledToFill()
                .cornerRadius(40)
            
            VStack{
              propertyHeader
                Spacer()
                propertyInfo
               
                VStack(alignment: .leading){
                    investmentInfo
                    investmentAnnalize
                }
                .padding(.vertical,16)
                .padding(.horizontal,12)
                .background(Color.white)
                .cornerRadius(16,corners: [.topLeft, .topRight])
                .cornerRadius(40,corners: [.bottomLeft, .bottomRight])
                 
            }
            .padding(4)
        }
        .frame(maxWidth: .infinity)
    }
}


extension PropertyCellView {
    
    private var propertyHeader: some View {
        HStack{
             Spacer()
            Button{
            } label: {
                Image(systemName: "\(Bool.random() ? "bookmark" : "bookmark.fill")")
                    .font(.system(size: 20))
                    .padding(24)
                    .background(Circle().stroke(Color.white, lineWidth: 0.5))
                    .foregroundColor(.white)
            }
        }
    }
    private var propertyInfo: some View {
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
            .background(Color.white)
            .cornerRadius(12)
            
            
            HStack{
                Text("AE".countryFlag)
                 Text("Dubai")
                    .font(.system(size: 11))
            }
            .frame(height:21)
            .padding(.horizontal,8)
            .background(Color.white)
            .cornerRadius(12)
            
            HStack{
                Image(systemName: "bed.double.fill")
                    .foregroundColor(Color(red: 0.35, green: 0.34, blue: 0.84))
                 Text("1 Bed")
                    .font(.system(size: 11))
            }
            .frame(height:21)
            .padding(.horizontal,8)
            .background(Color.white)
            .cornerRadius(12)
            
            HStack{
                Image("size")
                    .foregroundColor(Color(red: 0.35, green: 0.34, blue: 0.84))
                 Text("182 sq.ft")
                    .font(.system(size: 11))
            }
            .frame(height:21)
            .padding(.horizontal,8)
            .background(Color.white)
            .cornerRadius(12)
            Spacer()
            
        }
    }
    
    private var investmentInfo: some View {
        VStack(alignment: .leading) {
            Text("1 Bed in Old Town Downtown Dubai")
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
                .font(.system(size: 20).weight(.semibold))
            
            VStack(spacing: 4) {
                HStack{
                    Text("AED")
                        .font(.system(size: 13).weight(.semibold)) + Text(" 1,595,518")
                        .font(.system(size: 17).weight(.semibold))
                    Spacer()
                    
                    Text("48%")
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                    
                }
                .foregroundColor(.blue)
                
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.lightGray)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue)
                        .frame(width:50)
                    
                }
                .frame(height: 4)
                
                
            }
        }
    }
    
    private var investmentAnnalize: some View {
        HStack{
            Text("Annualise return")
                .foregroundColor(.gray)
                .font(.system(size: 13).weight(.medium))
            +
            Text(" 9.98%")
                .foregroundColor(.black)
                .font(.system(size: 13).weight(.semibold))
            
            Spacer()
            
            Text("Investment Period")
                .foregroundColor(.gray)
                .font(.system(size: 13).weight(.medium))
            +
            Text(" 1 Year")
                .foregroundColor(.black)
                .font(.system(size: 13).weight(.semibold))
        }
    }
}
