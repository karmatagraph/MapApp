//
//  MapAppApp.swift
//  MapApp
//
//  Created by karma on 5/31/22.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            LocationsView()
                .environmentObject(vm)
            
        }
    }
}
