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
       let totalInvested, totalProfitToDate, portfolioValue: Double
       let expectedProfitAfterYear: Double
}

// MARK: - Investment
struct Investment: Codable {
       let id: Int
       let name: String
       let invested: Double
       let images: [ImageInvested]
}


// MARK: - Image
struct ImageInvested: Codable {
    let path: String
}


let sampleInvestment = Investment(id: 1, name: "0", invested: 500, images: [ImageInvested(path: "")])
