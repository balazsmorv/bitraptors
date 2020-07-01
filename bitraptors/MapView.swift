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
    @EnvironmentObject var locationManager: LocationManager
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
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
                annotation.subtitle = venue.getCategory()
                annotation.coordinate = venue.getLocation()!
                mapView.addAnnotation(annotation)
            }
        }
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {

        view.showsUserLocation = true

        if CLLocationManager.locationServicesEnabled() {
            //        self.locationManager.delegate = self
            self.locationManager.getCLLocationManager().startUpdatingLocation()

            //Temporary fix: App crashes as it may execute before getting users current location
            //Try to run on device without DispatchQueue

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                let locValue:CLLocationCoordinate2D = self.locationManager.getCoordinates()
                print("CURRENT LOCATION = \(locValue.latitude) \(locValue.longitude)")

                let coordinate = CLLocationCoordinate2D(
                    latitude: locValue.latitude, longitude: locValue.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                view.setRegion(region, animated: true)

            })
        }

    }
}
