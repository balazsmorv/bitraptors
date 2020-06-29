//
//  MainView.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 29..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var venueList: VenueList
    
    var body: some View {
        TabView {
            ListView()
                .environmentObject(venueList)
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("on TV")
            }
            MapView()
                .environmentObject(venueList)
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
            }
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(VenueList().demo())
    }
}
