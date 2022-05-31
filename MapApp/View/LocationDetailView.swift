//
//  LocationDetailView.swift
//  MapApp
//
//  Created by karma on 5/31/22.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    let location: Location
    
    @EnvironmentObject var vm: LocationsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
            }
            
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton,alignment: .topLeading)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}

extension LocationDetailView {
    
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
                
                    
            }
        }
        .frame(height:500)
        .tabViewStyle(.page)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
                
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia",destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
           
        }
    }
    
    private var mapLayer: some View {
        Map(
            coordinateRegion: .constant(MKCoordinateRegion(
                center: location.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location]) { location in
                MapAnnotation(coordinate: location.coordinates) {
                    MapAnnotationView()
                        .shadow(radius: 10)
                }
            }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
            
        
//        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { locations in
//            MapAnnotation(coordinate: locations.coordinates) {
//                MapAnnotationView()
//                    .scaleEffect(vm.mapLocation == locations ? 1 : 0.7)
//                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 14)
//                    .onTapGesture {
//                        vm.showNextLocation(location: locations)
//                    }
//            }
//        })
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
            
        }

    }
        
    
}
