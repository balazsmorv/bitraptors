//
//  Venue.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 26..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import Foundation


final class VenueSearchResult: Decodable {
    //MARK: - Properties
    let metaData: MetaData
    let response: JSONResponse
    var venueList: [Venue]
    
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
        venueList = [Venue]()
        for item in response.groups[0].items {
            venueList.append(item.venue)
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

struct Group: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let venue: Venue
}
