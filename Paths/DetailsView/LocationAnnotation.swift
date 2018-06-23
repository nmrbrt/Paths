//
//  LocationAnnotation.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/23/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import Foundation

import MapKit

import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let id: String?
    let coordinate: CLLocationCoordinate2D
    
    init(id: String, title: String, subtitle: String, lat: Double, long: Double) {
        
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        19.406606261925184,-155.29370404121096
        super.init()
    }
    
}
