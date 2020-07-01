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
    
    // accounts
//    let clientID = "APEHQ0KDIWKVPJUFC0HSUZWEWGQRGVBVKZJZ1ZPBPHWIICZI"
//    let clientSecret = "IHPCXEWCEY03VDQUFUL4SLXHYTAUCPKKTKM4D3LMB3IYHPVT"
    
//    let clientID = "DPLXYVE0BSR5OUTL3OBTG5VLO2RRHHHQDTLE51U1EPGTKUGQ"
//    let clientSecret = "AO2KTWOFUSBEGC5Z2NL5WG35HQHWLWJIB2UL32RUX2EOCGTZ"
    
//    let clientID = "OOMFJUB1X4YNK04OKARGJSSRJP51VVCQMW5RTCJ03YIFWPVJ"
//    let clientSecret = "2PMTIAKNF3SIP4GPDVIXWYPNKNJYXZ0AOLHARE2PPIC1KB0L"

//    let clientID = "AFYRYZCHLWODNNY0MX2SR1H5DEGEST3RAHZFBGQTKEBEORBV"
//    let clientSecret = "2E4H1WV4FVNBPV1XABZYUMPKSAS3WJRNC4QPKMEG5SRIXZPV"
    
    let clientID = "INVAKXOZKWRQONSD02R0IWNVCCCZSOWAVELPYLVCZJ3K5BES"
    let clientSecret = "1MBZ541QH2XBR5KRTVKNJOLTOHSY1YPWP1W30S4UFLVGLEJC"
    
    
    
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
        print("loading venues")
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
        print("getting details")
        for id in ids {
            let url = """
            https://api.foursquare.com/v2/venues/\(id)?\
            &client_id=\(clientID)\
            &client_secret=\(clientSecret)\
            &v=\(version)
            """
            DispatchQueue.global(qos: .userInitiated).async {
                self.makeAPIRequest(url: url, completionHandler: self.gotVenueDetails)
            }
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
