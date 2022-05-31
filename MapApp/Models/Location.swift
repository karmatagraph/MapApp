//
//  Location.swift
//  MapApp
//
//  Created by karma on 5/31/22.
//

import Foundation
import MapKit

struct Location:Identifiable, Equatable {
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    // confromance to Identifiable because we used an id
    var id: String {
        name + cityName
    }
    
    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}
