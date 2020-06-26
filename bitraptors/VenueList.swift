//
//  VenueList.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 26..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import Foundation


class VenueList: Decodable, SearchResultsAvailableDelegate {
    
    let items: [Venue]
    
    init() {
        items = [Venue]()
    }
    
    func newDataCame(new list: VenueList) {
        print("new search results came in")
    }
}
