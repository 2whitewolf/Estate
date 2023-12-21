//
//  PropertiesList.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PropertiesList: View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var vm: PropertiesViewModel = PropertiesViewModel()

    var body: some View {
        ZStack{
            Color.white
            VStack(spacing: 0){
               headerView
               titleView
                    .padding(.top,6)
                selectionView
                ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(vm.properties, id: \.id) { property in
                                NavigationLink{
                                    //                            InvestmentDetails()
                                    PropertyDetailView(property: property)
                                        .navigationBarHidden(true)
                                        .environmentObject(vm)
                                        .environmentObject(appVM)
                                } label: {
                                    PropertyCellView(property: property)
                                        .environmentObject(appVM)
                                        .environmentObject(vm)
                                }
                                
                            }
                        }
                }
                .padding(.top,23)
            }
            .padding(.horizontal,8)
            if vm.isLoading {
//                Color.black.opacity(0.4).ignoresSafeArea()
                ProgressView()
            }
              
        
        }
       
        .onAppear{
            if vm.appViewModel == nil {
                vm.appViewModel = appVM
            }
            vm.getDataOnMain()
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
    
    private var selectionView: some View {
            GeometryReader{ geo in
                ZStack{
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color(red: 0.46, green: 0.46, blue: 0.5).opacity(0.12))
                    /*#767680*/
                    
                    HStack{
                        ForEach(PropertiesListEnum.allCases, id: \.self) { el in
                            Text(el.rawValue.capitalized)
                                .font(.system(size: 13, weight: .semibold))
                                .frame(width: (geo.size.width - 4) / 2 , height:30 )
                                .background( vm.selectedList == el ? Color.white : Color.white.opacity(0.01))
                                .cornerRadius(32)
                                .onTapGesture {
                                    withAnimation(.linear) {
                                        vm.selectedList = el
                                    }
                                }
                        }
                    }
                    .padding(2)
                }
            }
            .frame(height:32)
    }
    private var headerView: some View {
        HStack{
            Spacer()
            
            NavigationLink{
                FavouritesView()
                    .navigationBarHidden(true)
                    .environmentObject(vm)
                    .onDisappear{
                        vm.getDataOnMain()
                    }
                   
            } label: {
                Image(systemName: "heart")
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



