//
//  PropertyDetail.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 19.10.2023.
//
//

import Foundation

// MARK: - PropertyDetailData
struct PropertyDetailData: Codable {
    let responseCode: ResponseCode?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let property: PropertyDetail?
    let similar: [Property]?
}


// MARK: - Property
struct PropertyDetail: Codable {
    let id: Int?
    var name: String?
    var totalPrice, price: Double?
    var annualProfit: String?
    var sellPrice, appFee,additionalCharges: Double?
    var period, handover, location, coordinateX: String?
    var coordinateY, developer, developerSpecsTitle, developerSpecsSubtitle: String?
    var type: String?
    var bed, meter, sold, completed: Int?
    var about: String?
    var investors, needed, funded: Double?
    var dldFee, dubXfee: Double?
    var registrationFee: Int?
    var netIncome: String?
    var images: [ImageData]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case totalPrice = "total_price"
        case price
        case annualProfit = "annual_profit"
        case sellPrice = "sell_price"
        case appFee = "app_fee"
        case additionalCharges = "additional_charges"
        case period, handover, location
        case coordinateX = "coordinate_x"
        case coordinateY = "coordinate_y"
        case developer
        case developerSpecsTitle = "developer_specs_title"
        case developerSpecsSubtitle = "developer_specs_subtitle"
        case type, bed, meter, sold, completed, about,investors, needed, funded, dldFee, dubXfee
        case registrationFee = "registration_fee"
        case netIncome = "net_income"
        case images
    }
}

extension PropertyDetail: Equatable {
    static func == (lhs: PropertyDetail, rhs: PropertyDetail) -> Bool {
            return lhs.id == rhs.id //&&
        }
}



var samplePropertyDetail: PropertyDetailData  =  PropertyDetailData(
    responseCode: ResponseCode(responseCode:"1"),
    data: DataClass(
        property: PropertyDetail(
            id: 1,
            name: "",
            totalPrice: 122882.00,
            price: 5652.00,
            annualProfit: "",
            sellPrice: 59999412.00,
            appFee: 22.00,
            additionalCharges: 10002,
            period: "",
            handover: "",
            location: "",
            coordinateX: "",
            coordinateY: "",
            developer: "",
            developerSpecsTitle: "",
            developerSpecsSubtitle: "",
            type: "",
            bed: 2,
            meter: 120,
            sold: 1,
            completed: 0,
            about: "",
            investors: 0,
            needed: 0,
            funded: 0,
            dldFee: 11059.38,
            dubXfee: 27034.04,
            registrationFee: 0,
            netIncome: "151144.86",
            images: [
                ImageData(id: 41,
                          path: "",
                          mainImage: 1),
                ImageData(id: 48,
                          path: "",
                          mainImage: 0)
            ]
        ),
        similar: [
            Property(
                id: 5,
                totalPrice:1000000.00,
                annualProfit: "10, 20",
                period: "2, 5",
                location: "Sample Location3",
                bed: 3,
                meter: 120,
                type: "Ready",
                favorite: false,
                invested: nil,
                investors: nil,
                funded: nil,
                images: [
                    ImageData(
                        id: nil,
                        path: "property/5/images/img1.jpeg",
                        mainImage: nil)
                ]
            )
        ]
    )
)


struct PaymentData: Codable {
    let responseCode: ResponseCode?
        let data: PaymentDataClass?
}
 
struct PaymentDataClass: Codable {
    let clientSecret, publishableKey: String?

    enum CodingKeys: String, CodingKey {
        case clientSecret = "client_secret"
        case publishableKey = "publishable_key"
    }
}
