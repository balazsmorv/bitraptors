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
            
            
            if let suffix = self.venue.getPhotoData()?.suffix, let prefix = self.venue.getPhotoData()?.prefix, let url = URL(string: "\(prefix)36x36\(suffix)") {
                AsyncImage(url: url, placeholder: Text("Loading..."))
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.3), lineWidth: 4))
                    .shadow(radius: 5)
            } else {
                Image(uiImage: #imageLiteral(resourceName: "picture_not_found"))
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.3), lineWidth: 4))
                    .shadow(radius: 5)
            }
            
            

            Text(venue.getName()).frame(alignment: .leading)
            Spacer()
        
            Text(venue.getCategory()).font(.headline).fontWeight(.bold).foregroundColor(Color.blue).multilineTextAlignment(.leading).scaledToFit().opacity(0.8).shadow(radius: 10)
        }
        .padding(.trailing).padding(.leading)
    }
}

struct VenueListRowView_Previews: PreviewProvider {
    static var previews: some View {
        VenueListRowView(venue: Venue())
    }
}
