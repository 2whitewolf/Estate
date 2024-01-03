//
//  ShowMoreLessButton.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 10.11.2023.
//

import SwiftUI

struct ShowMoreLessButton: View {
    @Binding var tapped: Bool
    var body: some View {
        Button{
            withAnimation {
                tapped.toggle()
            }
        } label: {
            Label("Show \( tapped ? "less" : "more")", systemImage: tapped ?
                  "chevron.up" : "chevron.down")
                .foregroundColor(.blue)
                .font(.system(size: 13))
        }
    }
}

#Preview {
    ShowMoreLessButton(tapped: .constant(false))
}
