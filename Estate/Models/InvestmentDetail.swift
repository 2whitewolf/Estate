//
//  InvestmentDetail.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 17.11.2023.
//

import Foundation
struct InvestmentDetailData: Codable {
    let responseCode: ResponseCode
    let data: InvestmentDetail
}

// MARK: - DataClass
struct InvestmentDetail: Codable {
    let propertyValueToday: Double
    let investors: Int
    let funded: Double
    let investmentNeeded, propertyValueOnDateOfInvest: Double
    let annualisedReturn, investmentPeriod, totalInvestedAmount: String
    let userOwnership: Double
    let totalProfitToDate, expectedProfitAfterYear: Double
    let financial: Financial
}

// MARK: - Financial
struct Financial: Codable {
    let transactionCosts, dldFee, dubxFee, registrationFee: Double
    let investmentCost: Double
    let annualProfit, netIncome: String
}

/*
 
 {
     "responseCode": {
         "responseCode": "1"
     },
     "data": {
         "propertyValueToday": 1000000,
         "investors": 4,
         "funded": 0.62,
         "investmentNeeded": 993800,
         "propertyValueOnDateOfInvest": 1000000,
         "annualisedReturn": "35%",
         "investmentPeriod": "3 - 5",
         "totalInvestedAmount": "500.00",
         "userOwnership": 0.05,
         "totalProfitToDate": 0,
         "expectedProfitAfterYear": 175,
         "financial": {
             "transactionCosts": 121700,
             "dldFee": 90500,
             "dubxFee": 30000,
             "registrationFee": 1200,
             "investmentCost": 1121700,
             "annualProfit": "12% - 35%",
             "netIncome": "120000 - 350000"
         }
     }
 }
 */
let sampleInvestmentDetail = InvestmentDetail(propertyValueToday: 1000000, investors: 4, funded: 0.62, investmentNeeded: 993800, propertyValueOnDateOfInvest: 10000000, annualisedReturn: "35%", investmentPeriod: "3-5", totalInvestedAmount: "500.0", userOwnership: 0.05, totalProfitToDate: 0, expectedProfitAfterYear: 175, financial: Financial(transactionCosts: 121700, dldFee: 90500, dubxFee: 30000, registrationFee: 1200, investmentCost: 1121700, annualProfit: "12%-35%", netIncome: "120000 - 350000"))
