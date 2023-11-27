//
//  Transactions.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 24.11.2023.
//

import Foundation
struct Transaction: Codable, Hashable  {
    let amount: String?
    let dldFee: String?
    let appFee: String?
    let additionalChargesFee: String?
    let type: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case amount
        case dldFee = "dld_fee"
        case appFee = "app_fee"
        case additionalChargesFee = "additional_charges_fee"
        case type
        case createdAt = "created_at"
    }
}

struct AccountInfo: Codable {
    let balance: String? // or use appropriate data type for balance
    let transactions: [Transaction]
}


var sampleTransaction: Transaction = Transaction(amount: "500.00", dldFee: "90500.00", appFee: "30000.00", additionalChargesFee: "1200.00", type: "investment", createdAt: "2023-11-13 07:26")
