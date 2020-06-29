//
//  MapView.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 25..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var venueList: VenueList
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        for venue in venueList.getAllVenue() {
            if venue.getLocation() != nil {
                let annotation = MKPointAnnotation()
                annotation.title = venue.getName()
                annotation.subtitle = venue.getCategory().name
                annotation.coordinate = venue.getLocation()!
                mapView.addAnnotation(annotation)
            }
        }
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
