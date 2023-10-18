//
//  InvestmentCalculatorView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 20.09.2023.
//

import SwiftUI

struct InvestmentCalculatorView: View {
    @State var slider1: Double = 2.0
    @State var slider2: Double = 5.0
    var body: some View {
        VStack(spacing: 16){
            HStack{
                Text("Investment Calculator")
                    .font(.system(size: 20).weight(.semibold))
                    .foregroundColor(.black)
                 Spacer()
                 Image(systemName: "info.circle")
                    .foregroundColor(.gray)
            }
            Text("Projected Return On Investment in 1 year")
                .font(.system(size: 15))
                .foregroundColor(.gray)
              
          
                Text("AED")
                    .font(.system(size: 15).weight(.semibold))
                    .foregroundColor(.blue)
                
                +
                Text("13,851")
                    .font(.system(size: 28).weight(.bold))
                    .foregroundColor(.blue)
           
               
            VStack(spacing: 0) {
                HStack{
                    Text("Initial investment")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("AED 3000")
                        .fontWeight(.semibold)
                }
                .font(.system(size: 13))
                
                Slider(value: $slider1, in: 1.0...30.0)
            }
            
            VStack(spacing: 0) {
                HStack{
                    Text("Property Value Growth (1 Year)")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("50%")
                        .fontWeight(.semibold)
                }
                .font(.system(size: 13))
                
                Slider(value: $slider2, in: 1.0...30.0)
            }
            
            
        }
        .modifier(CornerBackground())
    }
}

struct InvestmentCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentCalculatorView()
    }
}
