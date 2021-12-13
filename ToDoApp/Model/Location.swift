//
//  Location.swift
//  ToDoApp
//
//  Created by Артем Хребтов on 13.12.2021.
//

import Foundation
import CoreLocation

struct Location {
    
    let name: String
    let coordinates: CLLocationCoordinate2D?
    
    init (name: String,
          coordinates: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinates = coordinates
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        guard lhs.coordinates?.longitude == rhs.coordinates?.longitude &&
                lhs.coordinates?.latitude == rhs.coordinates?.latitude &&
                lhs.name == rhs.name else { return false }
        return true
    }
    
    
}
