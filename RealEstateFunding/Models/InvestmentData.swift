//
//  InvestmentData.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 10.11.2023.
//

import Foundation
struct InvestmentsData: Codable {
    let responseCode: ResponseCode
    let data: InvestmentDataClass
}

// MARK: - DataClass
struct InvestmentDataClass: Codable {
    let investments: [Investment]
    let totalInvested: Int
}

// MARK: - Investment
struct Investment: Codable {
    let id, amount: Int
    let property: PropertyInvested
}

// MARK: - Property
struct PropertyInvested: Codable {
    let id: Int
    let name: String
    let bed: Int
    let images: [ImageInvested]
}

// MARK: - Image
struct ImageInvested: Codable {
    let path: String
}
