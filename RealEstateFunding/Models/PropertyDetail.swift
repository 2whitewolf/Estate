////
////  PropertyDetail.swift
////  RealEstateFunding
////
////  Created by iMacRoman on 19.10.2023.
////
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
    let name, totalPrice, price, annualProfit: String?
    let sellPrice, appFee: String?
    let additionalCharges: Int?
    let period, handover, location, coordinateX: String?
    let coordinateY, developer, developerSpecsTitle, developerSpecsSubtitle: String?
    let type: String?
    let bed, meter, sold, completed: Int?
    let about: String?
    let investors, needed, funded: Int?
    let dldFee, dubXfee: Double?
    let registrationFee: Int?
    let netIncome: String?
    let images: [ImageData]?

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
        case type, bed, meter, sold, completed, about, investors, needed, funded, dldFee, dubXfee
        case registrationFee = "registration_fee"
        case netIncome = "net_income"
        case images
    }
}

extension PropertyDetail: Equatable {
    static func == (lhs: PropertyDetail, rhs: PropertyDetail) -> Bool {
            return lhs.id == rhs.id //&&
//                lhs.name == rhs.name &&
//                lhs.email == rhs.email &&
//                lhs.birth == rhs.birth &&
//                lhs.phone == rhs.phone &&
//                lhs.citizenship == rhs.citizenship &&
//                lhs.country == rhs.country &&
//                lhs.city == rhs.city &&
//                lhs.address == rhs.address &&
//                lhs.employment == rhs.employment &&
//                lhs.organization == rhs.organization &&
//                lhs.orgRole == rhs.orgRole &&
//                lhs.workingPeriod == rhs.workingPeriod &&
//                lhs.industry == rhs.industry &&
//                lhs.income == rhs.income &&
//                lhs.netWorth == rhs.netWorth &&
//                lhs.emailVerifiedAt == rhs.emailVerifiedAt &&
//                lhs.stripeID == rhs.stripeID
        }
}



var samplePropertyDetail: PropertyDetailData  =  PropertyDetailData(
    responseCode: ResponseCode(responseCode:"1"),
    data: DataClass(
        property: PropertyDetail(
            id: 1,
            name: "updated1 2",
            totalPrice: "122882.00",
            price: "5652.00",
            annualProfit: "123",
            sellPrice: "59999412.00",
            appFee: "22.00",
            additionalCharges: 10002,
            period: "252",
            handover: "372",
            location: "Sample Location 2",
            coordinateX: "123.4564",
            coordinateY: "78.9104",
            developer: "Sample Developer",
            developerSpecsTitle: "Sample Title 1",
            developerSpecsSubtitle: "Sample Subtitle",
            type: "Ready",
            bed: 2,
            meter: 120,
            sold: 1,
            completed: 0,
            about: "This is a sample property description.",
            investors: 0,
            needed: 0,
            funded: 0,
            dldFee: 11059.38,
            dubXfee: 27034.04,
            registrationFee: 0,
            netIncome: "151144.86",
            images: [
                ImageData(id: 41,
                          path: "property/1/images/heart.png",
                          mainImage: 1),
                ImageData(id: 48,
                          path: "property/1/images/png-icon.png",
                          mainImage: 0)
            ]
        ),
        similar: [
            Property(
                id: 5,
                totalPrice:"1000000.00",
                annualProfit: "10, 20",
                period: "2, 5",
                location: "Sample Location3",
                bed: 3,
                meter: 120,
                type: "Ready",
                invested: nil,
                investors: nil,
                funded: nil,
                images: [
                    ImageData(
                        id: nil,
                        path: "property/5/images/img1.jpeg",
                        mainImage: nil)
                ]
            ),
            Property(
                id: 29,
                totalPrice: "1.00",
                annualProfit: "3",
                period: "7",
                location: "mol",
                bed: 3,
                meter: 42,
                type: "Ready",
                invested: nil,
                investors: nil,
                funded: nil,
                images: []
            ),
            Property(
                id: 31,
                totalPrice: "11111.00",
                annualProfit: "2",
                period: "6",
                location: "mol",
                bed: 3323,
                meter: 22,
                type: "Ready",
                invested: nil,
                investors: nil,
                funded: nil,
                images: [
                    ImageData(
                        id: nil,
                        path: "property/31/images/heart.png",
                        mainImage: nil
                    )
                ]
            )
        ]
    )
)
