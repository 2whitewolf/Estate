//
//  TabBarViewModifier.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI

struct TabBarViewModifire<Content: View>: View {
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            content
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(edges: .bottom)
    }
}
