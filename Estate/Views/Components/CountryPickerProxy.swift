//
//  CountryPickerProxy.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.09.2023.
//

import Foundation
import UIKit
import SwiftUI
import CountryPicker

struct CountryPickerViewProxy: UIViewControllerRepresentable {
    
    let onSelect: (( _ chosenCountry: Country) -> Void)?
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: CountryPickerController.create {
            onSelect?($0)}
        )
    }
}
