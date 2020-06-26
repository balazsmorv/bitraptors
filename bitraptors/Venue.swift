//
//  Venue.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 26..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import Foundation


class Venue: Decodable {
    //MARK: - Properties
    let id = "N/A"
    let name = "N/A"
    let contactInformation: ContactInformation
    let location: Location
    let category: VenueCategory
    let url = "N/A"
    let rating = "N/A"
    let openStatus: OpenStatus
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case contactInformation = "contact"
        case location
        case category = "categories"
        case url
        case rating
        case openStatus = "hours"
    }
    
}

struct ContactInformation: Decodable {
    let phone: String?
    let twitterName: String?
    let facebookName: String?
    let instagramName: String?
    
    enum CodingKeys: String, CodingKey {
        case phone
        case twitterName = "twitter"
        case facebookName = "facebookUsername"
        case instagramName = "instagram"
    }
}

struct Location: Decodable {
    let latitude: Double
    let longitude: Double
    let formattedAddress: FormattedAddress
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
        case formattedAddress
    }
}

struct FormattedAddress: Decodable {
    let first: String
    let second: String
    let third: String
    
    enum CodingKeys: String, CodingKey {
        case first = "0"
        case second = "1"
        case third = "2"
    }
}

struct VenueCategory: Decodable {
    let name: String
}

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
}

struct OpenStatus: Decodable {
    let status: String
    let isOpen: Bool
}
