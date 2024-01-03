//
//  AppleSignInSwift.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import Foundation
import SwiftUI
import AuthenticationServices

final class AppleSignInSwift: UIViewRepresentable {
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: UIViewRepresentableContext<AppleSignInSwift>) {
    }
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
        return button
    }
}
