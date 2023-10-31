//
//  UserData.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 11.10.2023.
//

import Foundation

// MARK: - UserData
struct UserData: Codable {
    let token: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let id: Int
    let name, email, birth, phone: String
    let citizenship, country, city, address: String
    let employment, organization, orgRole, workingPeriod: String
    let industry, income, netWorth: String
    let emailVerifiedAt: String?
    let stripeID: String

    enum CodingKeys: String, CodingKey {
        case id, name, email, birth, phone, citizenship, country, city, address, employment, organization
        case orgRole = "org_role"
        case workingPeriod = "working_period"
        case industry, income
        case netWorth = "net_worth"
        case emailVerifiedAt = "email_verified_at"
        case stripeID = "stripe_id"
    }
}


extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id &&
                lhs.name == rhs.name &&
                lhs.email == rhs.email &&
                lhs.birth == rhs.birth &&
                lhs.phone == rhs.phone &&
                lhs.citizenship == rhs.citizenship &&
                lhs.country == rhs.country &&
                lhs.city == rhs.city &&
                lhs.address == rhs.address &&
                lhs.employment == rhs.employment &&
                lhs.organization == rhs.organization &&
                lhs.orgRole == rhs.orgRole &&
                lhs.workingPeriod == rhs.workingPeriod &&
                lhs.industry == rhs.industry &&
                lhs.income == rhs.income &&
                lhs.netWorth == rhs.netWorth &&
                lhs.emailVerifiedAt == rhs.emailVerifiedAt &&
                lhs.stripeID == rhs.stripeID
        }
}
