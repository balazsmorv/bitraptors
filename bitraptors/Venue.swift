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
    private let name: String
    private let contactInformation: ContactInformation?
    private let location: Location?
    private let category: [VenueCategory]
    private let url: String?
    private let rating: Double?
    private let openStatus: OpenStatus?
    private let photos: Photos
    
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
        case photos
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
    
    func getCategory() -> String {
        return category[0].name
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
    
    func getPhotoData() -> PhotoItem? {
        if photos.count > 0 {
            return photos.groups[0].items[0]
        } else {
            return nil
        }
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
        photos = Photos(count: 1, groups: [PhotoGroup(items: [PhotoItem(prefix: "", suffix: "", width: 0, height: 0)])])
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

fileprivate struct Location: Decodable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}


fileprivate struct VenueCategory: Decodable {
    let name: String
}

fileprivate struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
}

struct OpenStatus: Decodable {
    let status: String
    let isOpen: Bool
}


fileprivate struct Photos: Decodable {
    let count: Int
    let groups: [PhotoGroup]
}

fileprivate struct PhotoGroup: Decodable {
    let items: [PhotoItem]
}

struct PhotoItem: Decodable {
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
}
