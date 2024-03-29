//
//  ViewModifiers.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 10.10.2023.
//

import SwiftUI

struct CornerBackground: ViewModifier {
    func body(content: Content) -> some View {
//        ZStack{
//             RoundedRectangle(cornerRadius: 32)
//                .stroke(Color.gray, lineWidth: 0.5)
            content
                .padding(.vertical,24)
                .padding(.horizontal)
                .background( ZStack {
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.gray, lineWidth: 0.3)
    RoundedRectangle(cornerRadius: 32)
                        .fill(Color.white)
                        .padding(0.3)
                }
                )
//
//        }
//        .clipped()
        .padding(0.3)
    }
}
