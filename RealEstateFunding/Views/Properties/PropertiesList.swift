//
//  PropertiesList.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PropertiesList: View {
 
    @StateObject var vm: PropertiesViewModel = PropertiesViewModel()
    @EnvironmentObject var appVM: AppViewModel
    var body: some View {
        ZStack{
            Color.white
            VStack(spacing: 0){
               headerView
               titleView
                    .padding(.top,6)
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(vm.properties, id: \.id) { property in
                            NavigationLink{
                                //                            InvestmentDetails()
                                PropertyDetailView(id: property.id ?? 0)
                                    .navigationBarHidden(true)
                                    .environmentObject(vm)
                                    .environmentObject(appVM)
                            } label: {
                                PropertyCellView(property: property, image: "")
                            }
                            
                        }
                    }
                }
                .padding(.top,23)
                
             
            }
            .padding(.horizontal,8)
        }
       
        .onAppear{
            vm.getAllProperties()
        }
    }
}

struct PropertiesList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PropertiesList()
                .environmentObject(AppViewModel())
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
                .foregroundColor(.black)
          Spacer()
        }
        .padding(.leading)
    }
}



