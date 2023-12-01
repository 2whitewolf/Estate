//
//  Payment.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 24.11.2023.
//

import Foundation
struct PaymentAdditionals: Codable {
    let transactionCosts: Double
    let dldFee: Double
    let dubxFee: Double
    let registrationFee: Double
    let investmentCost: Double
}


var sampleAdditionalCosts: PaymentAdditionals = PaymentAdditionals(transactionCosts: 20.3, dldFee: 20.5, dubxFee: 20.7, registrationFee: 13, investmentCost: 500.40)
