//
//  PropertyImageView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 23.10.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PropertyImageView: View {
    var images: [ImageData]
    @State var index: Int = 0
    @State var alignment: Alignment
    var body: some View {
        ZStack(alignment: alignment){
            if images.count > 0 {
                if let path =  images[index].path {
                    WebImage(url: URL(string: "https://afehe-hwf.buzz/storage" + "/" + path)).placeholder(
                        Image("propertyBackImage")
                        
                    )
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.screenWidth - 16)
                    .frame(height:alignment == .bottom ? 283 : 400)
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded({ value in
                            if value.translation.width < 0 {
                                //                            withAnimation(.linear) {
                                index = index == images.count - 1 ? 0 : index + 1
                                //                            }
                            }
                            
                            if value.translation.width > 0 {
                                //                            withAnimation(.linear) {
                                index = index == 0 ? images.count - 1 : index - 1
                                //                            }
                            }
                        }))
                }
            } else {
                Image("propertyBackImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth - 16)
                    .frame(height:alignment == .bottom ? 283 : 400)
            }
            
            if images.count > 1{
                HStack{
                    ForEach(0..<images.count) { image in
                        if  image == index {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.white)
                                .frame(width: 24,height: 3)
                        } else {
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.white,lineWidth:1)
                                .frame(width: 24,height: 3)
                        }
                        
                        
                    }
                }
                .padding(8)
                //                .background(Color.gray)
            }
        }
    }
}
