//
//  FavouritesView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 20.09.2023.
//

import SwiftUI

struct FavouritesView: View {
    @Environment(\.presentationMode) var presentation
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
                    ForEach(1..<5) { _ in
                        NavigationLink{
                            PropertyDetailView()
                                .navigationBarHidden(true)
                        } label: {
                            PropertyCellView(image: "")
                        }
                    }                    
                }
            }
            .padding(.horizontal,8)
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
