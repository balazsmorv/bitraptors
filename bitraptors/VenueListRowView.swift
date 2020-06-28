//
//  VenueListRowView.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 28..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import SwiftUI

struct VenueListRowView: View {
    
    var venue: Venue
    
    var body: some View {
        HStack() {
            Image(uiImage: #imageLiteral(resourceName: "Place_Jacobins_Lyon"))
                .resizable()
                .frame(width: 40.0, height: 40.0, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.3), lineWidth: 4))
                .shadow(radius: 5)

            Text(venue.getName()).frame(alignment: .leading)
            Spacer()
        
            Text(venue.getCategory().name).font(.headline).fontWeight(.bold).foregroundColor(Color.blue).multilineTextAlignment(.leading).scaledToFit().opacity(0.8).shadow(radius: 10)
        }
        .padding(.trailing).padding(.leading)
    }
}

struct VenueListRowView_Previews: PreviewProvider {
    static var previews: some View {
        VenueListRowView(venue: Venue())
    }
}
