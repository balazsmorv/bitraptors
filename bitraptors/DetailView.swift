//
//  DetailView.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 28..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import SwiftUI


struct DetailView: View {
    var venue: Venue
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                GeometryReader { geo in
                    if let suffix = self.venue.getPhotoData()?.suffix, let prefix = self.venue.getPhotoData()?.prefix, let url = URL(string: "\(prefix)300x300\(suffix)") {
                        AsyncImage(url: url, placeholder: Text("Loading..."))
                            .frame(width: geo.size.width, height: geo.size.height * 0.9, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.3), lineWidth: 4))
                            .shadow(radius: 10)
                            
                            
                    } else {
                        Image(uiImage: #imageLiteral(resourceName: "picture_not_found"))
                            .resizable()
                            .frame(width: geo.size.width * 0.9)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.3), lineWidth: 4))
                            .shadow(radius: 10)
                            .padding(.trailing).padding(.leading)
                    }
                }.frame(height: 300, alignment: .center)
                .padding(.all, 10)
                
                Text(venue.getName())
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding([.top, .leading, .trailing])
                    .shadow(radius: 10)
                
                CustomHStack(name: "Rating", value: "\(String(format: "%.1f", venue.getRating() ?? 0)) / 10")
                
                CustomHStack(name: "Category", value: venue.getCategory())
                                
                CustomHStack(name: "Current opening", value: venue.getOpenStatus()?.status)
                
                CustomHStack(name: "Facebook", value: venue.getContactInformation()?.facebookName)
                
                CustomHStack(name: "Twitter", value: venue.getContactInformation()?.twitterName)
                
                CustomHStack(name: "Instagram", value: venue.getContactInformation()?.instagramName)
                
                if let url = URL(string: venue.getURL() ?? ""), UIApplication.shared.canOpenURL(url) {
                    Button("Show website") {
                        UIApplication.shared.open(url)
                    }.font(.title)
                }
            }
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(venue: Venue())
    }
}
