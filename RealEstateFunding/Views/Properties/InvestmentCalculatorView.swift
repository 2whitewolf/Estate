//
//  InvestmentCalculatorView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 20.09.2023.
//

import SwiftUI

struct InvestmentCalculatorView: View {
    @State var slider1: Double = 1000
    @State var slider2: Double = 5.0
    func xValue() -> Double {
        return self.slider1 + self.slider1 * self.slider2 / 100.0
         
    }
    
    
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
              
          
                Text("AED ")
                    .font(.system(size: 15).weight(.semibold))
                    .foregroundColor(.blue)
                
                +
            
            Text("\(xValue().rotate(0))")
                    .font(.system(size: 28).weight(.bold))
                    .foregroundColor(.blue)
           
               
            VStack(spacing: 0) {
                HStack{
                    Text("Initial investment")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("AED " + slider1.rotate(0))
                        .fontWeight(.semibold)
                }
                .font(.system(size: 13))
                
                Slider(value: $slider1, in: 1000...200000)
            }
            
            VStack(spacing: 0) {
                HStack{
                    Text("Property Value Growth (1 Year)")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(slider2.rotate(0) + "%")
                        .fontWeight(.semibold)
                }
                .font(.system(size: 13))
                
                Slider(value: $slider2, in: 1.0...100.0)
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
