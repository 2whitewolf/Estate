//
//  View + Ext.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI

fileprivate struct BackgroundModifier<Background: View>: ViewModifier {
    private let alignment: Alignment
    private let background: Background
    
    init(
        alignment: Alignment,
        @ViewBuilder background: () -> Background) {
            self.alignment = alignment
            self.background = background()
        }
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .background(alignment: alignment, content: { background })
        } else {
            content
                .background(background, alignment: alignment)
        }
    }
}

public extension View {
    
    /// Custom Background Modifier
    func background<Background: View>(
        alignment: Alignment = .center,
        @ViewBuilder view: () -> Background
    ) -> some View {
        self.modifier(BackgroundModifier(alignment: alignment, background: view))
    }
    
    func backgroundColor(_ color: Color) -> some View {
        self.background {
            color
        }
    }
    
    func backgroundColor(_ color: Color, edges: Edge.Set) -> some View {
        self.background {
            color
                .ignoresSafeArea(edges: edges)
        }
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

