//
//  Property.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.10.2023.
//




var sampleProp = Property(id: 1,
                          totalPrice: 122882.0,
                          annualProfit: "123",
                          period: "252",
                          location: "Sample Location 2",
                          bed: 2,
                          meter: 120,
                          type: "ready",
                          invested: nil,
                          //                     invested: "",
                          investors: 0,
                          funded: 0,
                          images: [
                            ImageData(id: 41,
                                      path: "property/1/images/heart.png",
                                      mainImage: 1),
                            ImageData(id: 48,
                                      path: "property/1/images/png-icon.png",
                                      mainImage: 0)])
import Foundation

//MARK: - PropertyData
struct PropertyData: Codable {
    let responseCode: ResponseCode
    let data: [Property]
}


// MARK: - Datum
struct Property: Codable {
    let id: Int?
    var totalPrice: Double?
    var  annualProfit, period, location: String?
    var bed, meter: Int?
    var type: String? // TypeEnum
    //    let invested: String?
    //    let invested: Int?
    //    let invested: Invested?
    var invested,investors, funded: Int?
    var images: [ImageData]
    
    enum CodingKeys: String, CodingKey {
        case id
        case totalPrice = "total_price"
        case annualProfit = "annual_profit"
        case period, location, bed, meter, type, invested, investors, funded, images
    }
}

// MARK: - Image
struct ImageData: Codable {
    let id: Int?
    var path: String?
    var mainImage: Int?
    
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
    let responseCode: String?
}


enum Invested: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Invested.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Invested"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    
    var value: Int {
        switch self {
        case .integer(let int):
            return int
        case .string(let string):
            return string.toInt()
        }
    }
}
