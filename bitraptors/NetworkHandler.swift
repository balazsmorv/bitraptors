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
    let clientID = "OOMFJUB1X4YNK04OKARGJSSRJP51VVCQMW5RTCJ03YIFWPVJ"
    let clientSecret = "2PMTIAKNF3SIP4GPDVIXWYPNKNJYXZ0AOLHARE2PPIC1KB0L"
    let version = "20200626"
    let limit = 10
    
    var userLocation: CLLocationCoordinate2D? {
        didSet {
            // do api call again
        }
    }
    
    var radius: Int {
        didSet {
            // do api call again
        }
    }
    
    var delegate: SearchResultsAvailableDelegate?
    
    // MARK: - Functions
    init() {
        self.radius = 1000 //meters
        self.userLocation = CLLocationCoordinate2D()
        userLocation?.latitude = 47.0927
        userLocation?.longitude = 17.9135
    }
    
    func makeAPIRequest() {
        let url = """
        https://api.foursquare.com/v2/venues/explore?\
        client_id=\(clientID)\
        &client_secret=\(clientSecret)\
        &ll=\(userLocation!.latitude),\(userLocation!.longitude)\
        &radius=\(radius)\
        &limit=\(limit)\
        &v=\(version)
        """
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
        cachePolicy: .useProtocolCachePolicy,
        timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: requestCompleted(_:_:_:))
        dataTask.resume()
    }
    
    private func requestCompleted(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void {
        if error != nil {
            print(error!)
        } else {
            if data != nil {
                do {
                    
                    let venueSearchResult = try JSONDecoder().decode(VenueSearchResult.self, from: data!)
                    delegate?.newDataCame(new: venueSearchResult.venueList)
                    
                } catch {
                    print("NetworkHandler::requestCompleted() -> Parsing the JSON was not successfull, error: \(error)")
                }
            } else {
                print("NetworkHandler::requestCompleted() -> the data parameter was nil.")
            }
        }
    }
    
}


protocol SearchResultsAvailableDelegate: class {
    func newDataCame(new venues: [Venue]) -> Void
    func initialize(from dictionary: NSDictionary)
}
