//
//  PropertyCellView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.10.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PropertyCellView: View {
    @EnvironmentObject var vm: PropertiesViewModel
    let columns = [
        GridItem(.flexible(minimum: 50, maximum: 200))
       ]
   @State var property: Property
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
                vm.favoriteButtonPressed(property: property)
                property.favorite?.toggle()
            } label: {
                Image(systemName: "\(property.favorite ?? false ?  "heart.fill" : "heart")")
                    .font(.system(size: 20))
                    .padding(24)
                    .background(Circle().stroke(Color.white, lineWidth: 0.5))
                    .foregroundColor(.white)
            }
        }
    }
    
    private var propertyInfo: some View {
        var status: some View {
            HStack{
                Circle()
                    .fill(Color.blue)
                    .frame(width: 8)
                Text("\(property.type ?? "")".capitalized)
                    .font(.system(size: 11))
                    .foregroundColor(.black)
            }
            .frame(height:21)
            .padding(.horizontal,8)
            .background(Color.white)
            .cornerRadius(12)
        }
        
        var country :some View {
            HStack{
                Spacer().frame(width: 8)
                Text("AE".countryFlag)
                Text(property.location ?? "")
                    .font(.system(size: 11))
                    .foregroundColor(.black)
                    .lineLimit(1)
                Spacer().frame(width: 8)
            }
            .frame(height:21)
//            .padding(.horizontal,8)
            .background(Color.white)
            .cornerRadius(12)
        }
        
        var bed: some View {
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
        }
        
        var space: some View {
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
        }
        
        let array: [AnyView] = [AnyView( status),AnyView( country),AnyView( bed), AnyView(space)]
        
      return  FlexibleView(data: array.indices, spacing: 8, alignment: .leading) { item in
            array[item]
            
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
    PropertyCellView(property: sampleProp)
}
