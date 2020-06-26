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
    
    override init() {
        super.init()
        
    }
    
}
