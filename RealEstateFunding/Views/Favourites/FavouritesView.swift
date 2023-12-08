//
//  FavouritesView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 20.09.2023.
//

import SwiftUI

struct FavouritesView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var vm: PropertiesViewModel
    @EnvironmentObject var appVM: AppViewModel
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
              
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .padding(12)
                            .background(
                                Circle().stroke(Color.gray, lineWidth: 0.5)
                             
                            )
                    }
                 
                
                Text("Favourites")
                    .foregroundColor(.black)
                    .font(.system(size: 34).weight(.bold))
                    .padding(.leading,22)
                
                ScrollView(showsIndicators: false) {
                    ForEach(vm.properties, id: \.id) { property in
                        NavigationLink{
                            if let propertyID = property.id {
                                PropertyDetailView(id: propertyID)
                                    .navigationBarHidden(true)
                                    .environmentObject(vm)
                                    .environmentObject(appVM)
                            }
                        } label: {

                            PropertyCellView(property: property, delete: true)
                        }
                    }                    
                }
            }
            .padding(.horizontal,8)
            if vm.properties.isEmpty {
                ProgressView()
            }
        }
        .onAppear{
//            if let user = appVM.user {
                vm.properties.removeAll()
                vm.getFavouriteProperties()
//            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
