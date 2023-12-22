//
//  PaymentAgree.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 11.12.2023.
//

import SwiftUI

struct PaymentAgree: View {
    @Binding var presentAgree: Bool
    @Binding var goNext: Bool
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button{
                    presentAgree.toggle()
                } label: {
                    
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal,20)
            VStack(spacing:24){
                Text("Agreement".localized)
                    .foregroundColor(.black)
                    .font(.system(size: 28).weight(.bold))
                Group {
                    Text("By confirming your investment you agree with our ".localized)
                    
                    + Text("Terms & Conditions".localized)
                        .foregroundColor(.blue)
                        .font(.system(size: 15).weight(.bold))
                    + Text(" " + "and".localized + " ")
                    + Text("Key Risks".localized)
                        .font(.system(size: 15).weight(.bold))
                        .foregroundColor(.blue)
                }
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                Button{
                    confirmation()
                } label: {
                    Text("I Agree".localized)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(14)
            }
            .padding(.horizontal,32)
            .padding(.bottom,18)
        }
        .padding(.vertical,20)
        .background(Color.white)
        .cornerRadius(40)
    }
    @MainActor
    fileprivate func confirmation() {
       goNext = true
    }
}

//#Preview {
//    PaymentAgree()
//}
