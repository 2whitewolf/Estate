//
//  Country.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 07.11.2023.
//

import Foundation
struct CountryData: Codable{
    let data: [CountryJson]
}

struct CountryJson: Identifiable, Codable{
    let id = UUID()
    let cities: [String]
    let country: String
    let iso2: String
    let iso3: String
}
