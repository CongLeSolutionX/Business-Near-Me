//
//  BusinessSite.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//

// MARK: - BussinessLocation
struct BussinessLocation: Codable {
    let businesses: [Business]?
    let total: Int?
    let region: Region?
}

// MARK: - Business
struct Business: Codable {
    let id, alias, name: String?
    let imageURL: String?
    let isClosed: Bool?
    let url: String?
    let reviewCount: Int?
    let categories: [Category]?
    let rating: Double?
    let coordinates: Center?
    let transactions: [String]?
    let price: String?
    let location: Location?
    let phone, displayPhone: String?
    let distance: Double?
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String?
}

// MARK: - Center
struct Center: Codable {
    let latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable {
    let address1: String?
    let address2, address3: String?
    let city, zipCode, country, state: String?
    let displayAddress: [String]?
}

// MARK: - Region
struct Region: Codable {
    let center: Center?
}
