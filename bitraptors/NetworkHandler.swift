//
//  NetworkHandler.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 25..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation


class NetworkHandler {
    
    // MARK: - Properties
    let clientID3 = "APEHQ0KDIWKVPJUFC0HSUZWEWGQRGVBVKZJZ1ZPBPHWIICZI"
    let clientID2 = "DPLXYVE0BSR5OUTL3OBTG5VLO2RRHHHQDTLE51U1EPGTKUGQ"
    let clientID = "OOMFJUB1X4YNK04OKARGJSSRJP51VVCQMW5RTCJ03YIFWPVJ"
    let clientSecret3 = "IHPCXEWCEY03VDQUFUL4SLXHYTAUCPKKTKM4D3LMB3IYHPVT"
    let clientSecret2 = "AO2KTWOFUSBEGC5Z2NL5WG35HQHWLWJIB2UL32RUX2EOCGTZ"
    let clientSecret = "2PMTIAKNF3SIP4GPDVIXWYPNKNJYXZ0AOLHARE2PPIC1KB0L"
    let version = "20200626"
    let limit = 30
    
    var userLocation: CLLocationCoordinate2D?
    var radius: Int
    
    var delegate: SearchResultsAvailableDelegate?
    
    // MARK: - Functions
    init() {
        self.radius = 1000 //meters
        self.userLocation = CLLocationCoordinate2D()
        userLocation?.latitude = 47.0927
        userLocation?.longitude = 17.9135
    }
    
    func loadVenues() {
        let url = """
        https://api.foursquare.com/v2/venues/explore?\
        client_id=\(clientID)\
        &client_secret=\(clientSecret)\
        &ll=\(userLocation!.latitude),\(userLocation!.longitude)\
        &radius=\(radius)\
        &limit=\(limit)\
        &v=\(version)
        """
        makeAPIRequest(url: url, completionHandler: requestCompleted(_:_:_:))
    }
    
    func makeAPIRequest(url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        print("making request")
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
        cachePolicy: .useProtocolCachePolicy,
        timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
        dataTask.resume()
    }
    
    private func requestCompleted(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void {
        if error != nil {
            print(error!)
        } else {
            if data != nil {
                do {
                    
                    let venueSearchResult = try JSONDecoder().decode(VenueSearchResult.self, from: data!)
                    getDetails(for: venueSearchResult.venueIDs)
                    
                } catch {
                    print("NetworkHandler::requestCompleted() -> Parsing the JSON was not successfull, error: \(error)")
                }
            } else {
                print("NetworkHandler::requestCompleted() -> the data parameter was nil.")
            }
        }
    }
    
    private func getDetails(for ids: [String]) {
        print(ids)
        for id in ids {
            let url = """
            https://api.foursquare.com/v2/venues/\(id)?\
            &client_id=\(clientID)\
            &client_secret=\(clientSecret)\
            &v=\(version)
            """
            print(url)
            makeAPIRequest(url: url, completionHandler: gotVenueDetails)
        }
    }
    
    private func gotVenueDetails(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        if error != nil {
            print(error!)
        } else {
            if data != nil {
                do {
                    
                    let venueSearchResult = try JSONDecoder().decode(VenueDetailResult.self, from: data!)
                    delegate?.newDataCame(new: venueSearchResult.venue)
                    
                } catch {
                    print("NetworkHandler::gotVenueDetails() -> Parsing the JSON was not successfull, error: \(error)")
                }
            } else {
                print("NetworkHandler::gotVenueDetails() -> the data parameter was nil.")
            }
        }
    }
    
}


protocol SearchResultsAvailableDelegate: class {
    func newDataCame(new venue: Venue) -> Void
}
