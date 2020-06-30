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
        VStack {
            GeometryReader { geo in
                if let url = URL(string: "\(self.venue.getPhotoData()!.prefix)300x300\(self.venue.getPhotoData()!.suffix)") {
                    AsyncImage(url: url, placeholder: Text("Loading..."))
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.9)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.3), lineWidth: 4))
                        .shadow(radius: 10)
                        .padding(.leading).padding(.trailing)
                } else {
                    Image(uiImage: #imageLiteral(resourceName: "picture_not_found"))
                        .resizable()
                        .frame(width: geo.size.width * 0.9)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.3), lineWidth: 4))
                        .shadow(radius: 10)
                        .padding(.trailing).padding(.leading)
                }
            }
            
                
            Text(venue.getName())
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding([.top, .leading, .trailing])
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            HStack {
                Text(String(format: "%.1f", venue.getRating() ?? 0))
                    .font(.title)
                    .fontWeight(.light)
                    .shadow(radius: 20)
                Spacer()
                Text("\(venue.getContactInformation()?.phone ?? "no phone information")")
                    .font(.title)
                    .fontWeight(.light)
                    .shadow(radius: 20)
            }.padding(.leading).padding(.trailing)
        }.padding(.bottom)
    }
    
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(venue: Venue())
    }
}
