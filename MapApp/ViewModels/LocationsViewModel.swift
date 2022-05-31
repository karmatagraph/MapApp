//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by karma on 5/31/22.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All the locations loaded
    @Published var locations: [Location]
    
    // show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    // Current location on the map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // Current region on the map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    // Show list of locations
    @Published var showLocationList: Bool = false
    
    // We use the same span so declare a constant
    let mapSapn = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSapn)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func moreButtonTapped() {
        LocationDetailView(location: mapLocation)
    }
    
    func nextButtonTapped() {
//        let currentIndex = locations.firstIndex { location in
//            return location == mapLocation
//        }
        let currentIndex = locations.firstIndex(where: { $0 == mapLocation })
        guard let currentIndex = currentIndex else {
            print("couldn't find current index")
            return
        }
        
        // checking the next index is valid or not
        let nextIndex = currentIndex + 1
        // is there item in the index?
        guard locations.indices.contains(nextIndex) else {
            let firstLocation = locations.first
            // unwrap
            guard let firstLocation = firstLocation else {
                return
            }
            showNextLocation(location: firstLocation)
            return
        }
        
        // next index is valid
        showNextLocation(location: locations[nextIndex])
    }
    
}
