//
//  ListView.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 28..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import SwiftUI
import Combine

struct ListView: View {
    
    @EnvironmentObject var venueList: VenueList
    
    
    var body: some View {
        NavigationView {
            List(venueList.getAllVenue()) { venue in
                NavigationLink(destination: DetailView(venue: venue)) {
                    VenueListRowView(venue: venue)
                }
            }.navigationBarTitle("Places nearby")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(VenueList().demo())
    }
}
