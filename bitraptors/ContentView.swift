//
//  ContentView.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 25..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        MapView().edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
