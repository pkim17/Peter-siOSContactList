//
//  MapPoint.swift
//  Peter's Contact List
//
//  Created by Peter Kim on 11/20/19.
//  Copyright © 2019 Peter Kim. All rights reserved.
//

import Foundation
import MapKit

class MapPoint: NSObject, MKAnnotation{
    
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
