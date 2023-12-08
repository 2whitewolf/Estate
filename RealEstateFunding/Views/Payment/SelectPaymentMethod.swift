//
//  SelectPaymentMethod.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 04.12.2023.
//

import SwiftUI

struct SelectPaymentMethod: View {
    var body: some View {
        VStack{
            Text("Payment Methods")
             Divider()
            
            
            VStack(alignment: .leading, spacing: 16){
                Text("Wallet")
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                HStack{
                     Text("AED 0 ")
                        .font(.system(size: 15).weight(.semibold))
                    Spacer()
                }
                .foregroundColor(.gray)
            }
            .modifier(CornerBackground())
            
            VStack(alignment: .leading, spacing: 16){
                Text("Cards")
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                HStack{
                     Text("AED 0 ")
                        .font(.system(size: 15).weight(.semibold))
                    Spacer()
                }
                .foregroundColor(.gray)
            }
            .modifier(CornerBackground())
            
            VStack(alignment: .leading, spacing: 16){
                Text("Other methods")
                    .foregroundColor(.black)
                    .font(.system(size: 20).weight(.semibold))
                HStack{
                     Text("AED 0 ")
                        .font(.system(size: 15).weight(.semibold))
                    Spacer()
                }
                .foregroundColor(.gray)
            }
            .modifier(CornerBackground())
            
            Spacer()
            Button{
                
            } label: {
                Text("Continue")
                    .foregroundColor(.white)
                    .font(.system(size: 17).weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height:50)
                    .background(Color.blue)
                    .cornerRadius(14)
            }
            .padding()
        }
        .padding(.horizontal,8)
    }
}

#Preview {
    SelectPaymentMethod()
}
