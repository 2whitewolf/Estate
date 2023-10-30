//
//  Enum + Ext.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 26.10.2023.
//

import Foundation
import SwiftUI
extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
    func previous() -> Self {
        let all = Self.allCases.reversed()
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
       }
}
