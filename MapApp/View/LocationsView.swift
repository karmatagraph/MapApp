//
//  LocationsView.swift
//  MapApp
//
//  Created by karma on 5/31/22.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    let maxWidthforIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapView
                .ignoresSafeArea()
            VStack() {
                header
                    .padding()
                    .frame(maxWidth: maxWidthforIpad)
                Spacer()
                previewLayer
            }
            
        }
        .sheet(item: $vm.sheetLocation) { location in
            LocationDetailView(location: location)
        }
    }
    
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button {
                withAnimation(.interactiveSpring()){
                    vm.toggleLocationsList()
                }
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(
                        alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees:  vm.showLocationList ? 180 : 0))
                        }
            }
            
            if vm.showLocationList{
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        
    }
    
    private var mapView: some View {
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { locations in
            MapAnnotation(coordinate: locations.coordinates) {
                MapAnnotationView()
                    .scaleEffect(vm.mapLocation == locations ? 1 : 0.7)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 14)
                    .onTapGesture {
                        vm.showNextLocation(location: locations)
                    }
            }
        })
    }
    
    private var previewLayer: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .frame(maxWidth: maxWidthforIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
    
}
