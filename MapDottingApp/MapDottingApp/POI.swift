//
//  POI.swift
//  MapDottingApp
//

import Foundation
import CoreLocation

// PoIの定義
struct Spot: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
