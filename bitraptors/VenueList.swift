//
//  VenueList.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 26..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


// The ViewModel in MVVM
class VenueList: ObservableObject {
    
    //MARK: - Properties
    
    // stores the venues. When changed, the ui redraws itself
    @Published private(set) var venues = [Venue]()
    @Published private(set) var pictures = [Venue : Image]()
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    //MARK: - Functions
    
    func getVenue(at index: Int) -> Venue? {
        return (index < venues.count && index >= -1) ? venues[index] : nil
    }
    
    func getAllVenue() -> [Venue] {
        return venues
    }
    
    func addVenue(new venue: Venue) {
        venues.append(venue)
    }
    
    func demo() -> VenueList {
        for _ in 0..<30 {
            venues.append(Venue())
        }
        return self
    }
    
}

//MARK: - Conformance to protocol SearchResultsAvailableDelegate
extension VenueList: SearchResultsAvailableDelegate {
    func newDataCame(new venue: Venue) {
        DispatchQueue.main.async {
            self.venues.append(venue)
        }
    }
}
