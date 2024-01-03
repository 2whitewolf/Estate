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
//    @EnvironmentObject var appVM: AppViewModel
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                HStack{
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
                     Spacer()
                }
                 
                
                Text("Favourites".localized)
                    .foregroundColor(.black)
                    .font(.system(size: 34).weight(.bold))
                    .padding(.leading,22)
                if !vm.favoriteProperties.isEmpty{
                    ScrollView(showsIndicators: false) {
                        ForEach(vm.favoriteProperties, id: \.id) { property in
                            NavigationLink{
                                PropertyDetailView(property: property)
                                    .navigationBarHidden(true)
                                    .environmentObject(vm)
                            } label: {
                                
                                PropertyCellView(property: property)
                            }
                        }
                    }
                } else {
                    VStack{
                        VStack(spacing: 8){
                            Image(systemName: "info.circle")
                            Text("No properties in favorites".localized)
                                .font(.system (size: 15))
                                .padding(.top,8)
                           
                            
                        }
                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                        .padding(.vertical,32)
                        .frame(maxWidth: .infinity)
                        .modifier(CornerBackground())
                         Spacer()
                        
                    }
                    
                    
                }
            }
            .padding(.horizontal,8)
            if vm.isLoading {
                Color.black.opacity(0.4).ignoresSafeArea()
                ProgressView()
            }
        }
        .onAppear{
                vm.getFavouriteProperties()
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
