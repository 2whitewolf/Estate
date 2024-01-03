//
//  Wallet.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 13.12.2023.
//

import Foundation
struct WalletData: Codable {
    let responseCode: ResponseCode?
    let data: WalletDataClass?
}

// MARK: - DataClass
struct WalletDataClass: Codable {
    let balance: Double?
}
