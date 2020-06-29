//
//  Venue.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 26..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import Foundation

final class VenueDetailResult: Decodable {
    let metaData: MetaData
    let response: JSONDetailsResponse
    var venue: Venue
    
    enum CodingKeys: String, CodingKey {
        case metaData = "meta"
        case response
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        metaData = try values.decode(MetaData.self, forKey: .metaData)
        response = try values.decode(JSONDetailsResponse.self, forKey: .response)
        venue = response.venue
    }
}

final class VenueSearchResult: Decodable {
    //MARK: - Properties
    let metaData: MetaData
    let response: JSONResponse
    var venueIDs = [String]()
    
    //MARK: - Coding keys for JSON decode
    enum CodingKeys: String, CodingKey {
        case metaData = "meta"
        case response
    }
    
    //MARK: - Init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        metaData = try values.decode(MetaData.self, forKey: .metaData)
        response = try values.decode(JSONResponse.self, forKey: .response)
        for item in response.groups[0].items {
            venueIDs.append(item.venue.id)
        }
    }
    
}

//MARK: - API metadata
struct MetaData: Decodable {
    let code: Int
    let requestId: String
}

//MARK: - API response field
struct JSONResponse: Decodable {
    let groups: [Group]
}

struct JSONDetailsResponse: Decodable {
    let venue: Venue
}

struct Group: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let venue: Venue
}
