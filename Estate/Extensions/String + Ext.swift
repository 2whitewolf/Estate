//
//  String + Ext.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 19.09.2023.
//

import Foundation
extension String {
    var countryFlag : String {
        String(String.UnicodeScalarView(self.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }))
    }
    
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    var localized: String {
        
        return NSLocalizedString(self, comment: "")
        
    }
}
