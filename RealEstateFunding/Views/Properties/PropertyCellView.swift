//
//  PropertyCellView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.10.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PropertyCellView: View {
    let columns = [
        GridItem(.adaptive(minimum: 80))
       ]
    var property: Property
    var image: String
    var body: some View {
        ZStack{
            
            PropertyImageView(images: property.images, alignment: .top )
        
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
            .frame(height: 392)
            .padding(4)
           
        }
        .backgroundColor(.gray)
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .cornerRadius(40)
       
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
                Text("\(property.type ?? "")")
                    .font(.system(size: 11))
                    .foregroundColor(.black)
            }
            .frame(height:21)
            .padding(.horizontal,8)
            .background(Color.white)
            .cornerRadius(12)
            
            
            HStack{
                Text("AE".countryFlag)
                Text(property.location ?? "")
                    .font(.system(size: 11))
                    .foregroundColor(.black)
            }
            .frame(height:21)
            .padding(.horizontal,8)
            .background(Color.white)
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
            .background(Color.white)
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
            .background(Color.white)
            .cornerRadius(12)
            Spacer()
            
        }
    }
    
    private var investmentInfo: some View {
   
        VStack(alignment: .leading) {
            Text("\(property.bed ?? 0) Bed in " + (property.location ?? "") )
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
                .font(.system(size: 20).weight(.semibold))
            
            VStack(spacing: 4) {
                HStack{
                    Text("AED ")
                        .font(.system(size: 13).weight(.semibold)) + Text(property.totalPrice?.rotate(2) ?? "")
                        .font(.system(size: 17).weight(.semibold))
                    Spacer()
                    
                    Text("\(property.invested?.value ?? 0)" + "%")
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                    
                }
                .foregroundColor(.blue)
                GeometryReader { geometry in
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.lightGray)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.blue)
                            .frame(width: (Double(property.invested?.value ?? 1) / Double(property.totalPrice ?? 1 )) * (geometry.size.width))
                    }
                }
                .frame(height: 4)
                
                
            }
        }
    }
    
    private var investmentAnnalize: some View {
        HStack{
            Text("Annual profit ")
                .foregroundColor(.gray)
                .font(.system(size: 13).weight(.medium))
            +
            Text(property.annualProfit ?? "" + "%")
                .foregroundColor(.black)
                .font(.system(size: 13).weight(.semibold))
            
            Spacer()
            
            Text("Handover ")
                .foregroundColor(.gray)
                .font(.system(size: 13).weight(.medium))
            +
            Text((property.period ?? "") + " Year")
                .foregroundColor(.black)
                .font(.system(size: 13).weight(.semibold))
        }
    }
}


#Preview {
    PropertyCellView(property: sampleProp, image: "")
}
