//
//  Property.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.10.2023.
//

import Foundation

 //MARK: - PropertyData
struct PropertyData: Codable {
    let responseCode: ResponseCode
    let data: [Property]
}

// MARK: - Datum
struct Property: Codable {
    let id: Int
    let totalPrice, annualProfit, period, location: String
    let bed, meter: Int
    let type: TypeEnum
    let invested, investors, funded: Int
    let images: [ImageData]

    enum CodingKeys: String, CodingKey {
        case id
        case totalPrice = "total_price"
        case annualProfit = "annual_profit"
        case period, location, bed, meter, type, invested, investors, funded, images
    }
}

// MARK: - Image
struct ImageData: Codable {
    let id: Int
    let path: String
    let mainImage: Int

    enum CodingKeys: String, CodingKey {
        case id, path
        case mainImage = "main_image"
    }
}

enum TypeEnum: String, Codable {
    case apartment = "Apartment"
    case offPlan = "Off-plan"
    case ready = "Ready"
}

// MARK: - ResponseCode
struct ResponseCode: Codable {
    let responseCode: String
}
