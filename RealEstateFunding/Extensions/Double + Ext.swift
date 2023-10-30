//
//  Double + Ext.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 19.10.2023.
//

import Foundation

extension Double {
    func rotate(_ digit: Int) -> String  {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = digit
            numberFormatter.groupingSeparator = ","
            numberFormatter.groupingSize = 3
            return numberFormatter.string(from: NSNumber(value: self)) ?? "Error"
    }
}
