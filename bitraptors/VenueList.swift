//
//  VenueList.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 26..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import Foundation


class VenueList: Decodable {
    
    //MARK: - Properties
    private var items: [Venue]
    
    //MARK: - Functions
    init() {
        items = [Venue]()
    }
    
    func getVenue(at index: Int) -> Venue? {
        return items[index]
    }
    
}

//MARK: - Conformance to protocol SearchResultsAvailableDelegate
extension VenueList: SearchResultsAvailableDelegate {
    func newDataCame(new venues: [Venue]) {
        items = venues
    }
}
