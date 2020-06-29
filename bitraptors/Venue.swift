//
//  Venue.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 26..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import Foundation
import CoreLocation

struct VenueID: Decodable {
    let id: String
}

class Venue: Decodable, Identifiable {
    //MARK: - Properties
    let id: String
    let name: String
    let contactInformation: ContactInformation?
    let location: Location?
    let category: [VenueCategory]
    let url: String?
    let rating: Double?
    let openStatus: OpenStatus?
    
    //MARK: - Coding keys
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
    
    //MARK: - Getters
    func getName() -> String {
        return name
    }
    
    func getId() -> String {
        return id
    }
    
    func getContactInformation() -> ContactInformation? {
        return contactInformation
    }
    
    func getLocation() -> CLLocationCoordinate2D? {
        if let latitude = location?.latitude, let longitude = location?.longitude {
            var location = CLLocationCoordinate2D()
            location.latitude = latitude
            location.longitude = longitude
            return location
        } else {
            return nil
        }
    }
    
    func getCategory() -> VenueCategory {
        return category[0]
    }
    
    func getURL() -> String? {
        return url
    }
    
    func getRating() -> Double? {
        return rating
    }
    
    func getOpenStatus() -> OpenStatus? {
        return openStatus
    }
    
    //MARK: - Functions
    //just for demo
    init() {
        id = "id"
        name = "name"
        contactInformation = ContactInformation(phone: "phone number", twitterName: "@twittername", facebookName: "facebookname", instagramName: "instaname")
        location = Location(latitude: 50, longitude: 0)
        var c = [VenueCategory]()
        c.append(VenueCategory(name: "category"))
        category = c
        url = "url"
        rating = 10.0
        openStatus = OpenStatus(status: "open", isOpen: true)
    }
    
}

//MARK: - Supporting structs containing some details of the venue
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
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
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
