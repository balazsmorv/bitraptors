//
//  LocationManager.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 06. 26..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import Foundation
import CoreLocation
import Combine


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //MARK: - Properties
    private let locationManager = CLLocationManager()
    private var networkManager: NetworkHandler?
    private var locationLoadingBegan = false
    
    //MARK: - Init
    override init() {
        super.init()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func getCLLocationManager() -> CLLocationManager {
        return locationManager
    }
    
    func setNetworkManager(to networkManager: NetworkHandler) {
        self.networkManager = networkManager
        
        if CLLocationManager.locationServicesEnabled() {
             switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                case .authorizedAlways, .authorizedWhenInUse:
                    print("access granted, nm: \(networkManager)")
                    if !locationLoadingBegan {
                        networkManager.userLocation = self.getCoordinates()
                        locationLoadingBegan = true
                        DispatchQueue.global(qos: .userInteractive).async {
                            networkManager.loadVenues()
                        }
                    }
                }
            } else {
                print("Location services are not enabled")
        }
    }
    
    func getCoordinates() -> CLLocationCoordinate2D {
        if let coordinates = locationManager.location?.coordinate {
            return coordinates
        } else {
            var c = CLLocationCoordinate2D()
            c.latitude = 47.093
            c.longitude = 17.911
            return c
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            print("No access")
        case .authorizedAlways, .authorizedWhenInUse:
            if !locationLoadingBegan {
                networkManager?.userLocation = self.getCoordinates()
                networkManager?.loadVenues()
            }
        }
    }
}
