//
//  VenueList.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 26..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import Foundation
import Combine


class VenueList: ObservableObject {
    
    //MARK: - Properties
    
    // stores the venues. When changed, the ui redraws itself
    @Published private var venues = [Venue]()
    
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
    func newDataCame(new venues: [Venue]) {
        DispatchQueue.main.async {
            self.venues = venues
            for venue in self.venues {
                print(venue.name)
            }
        }
    }
    
    func initialize(from dictionary: NSDictionary) {
//        if let meta = dictionary.value(forKey: "meta") as? NSDictionary {
//            let code = meta.value(forKey: "code") as? Int
//            if code != 200 {
//                return
//            }
//        } else {
//            return
//        }
//
//        if let response = dictionary.value(forKey: "response") as? NSDictionary {
//            if let groups = response.value(forKey: "groups") as? NSArray {
//                // when does it return multiple groups? Dont know, so only use first group
//                if let group = groups[0] as? NSDictionary {
//                    if let items = group.value(forKey: "items") as? NSArray {
//                        for index in 0..<items.count {
//                            if let item = items[index] as? NSDictionary {
//                                if let venue = item.value(forKey: "venue") as? NSDictionary {
//
//                                } else { print("venue couldt be created")}
//                            } else { print("dict couldt be created")}
//                        }
//                    } else { print("items array couldnt be created")}
//                } else { print("group count be created")}
//            } else { print("groups couldnt be created")}
//        } else { print("response dictionary couldnt be created")}
    }
}
