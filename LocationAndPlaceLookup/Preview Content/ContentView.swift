//
//  ContentView.swift
//  LocationAndPlaceLookup
//
//  Created by Gary Erickson on 5/27/25.
//

import SwiftUI

struct ContentView: View {
    @State var locationManager = LocationManager()
    @State var selectedPlace: Place?
    @State private var sheetIsPresented: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(selectedPlace?.name ?? "n/a")
                    .font(.title2)
                
                Text(selectedPlace?.address ?? "n/a")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                Text("\(selectedPlace?.latitude ?? 0.0), \(selectedPlace?.longitude ?? 0.0)")
            }
            //Text("\(locationManager.location?.coordinate.longitude ?? 0.0), \(locationManager.location?.coordinate.latitude ?? 0.0) !")
            //let _ = print("Hello, world from \(locationManager.location?.coordinate.longitude ?? 0.0), \(locationManager.location?.coordinate.latitude ?? 0.0) !")
        }
        Spacer()
        
        Button {
            sheetIsPresented.toggle()
            
        } label: {
            Image(systemName: "location.magnifyingglass")
            Text("LocationSearch")
            
        }
        .padding()
        .task {
            //get userlocation one when the view appears
            // handle case if user already authoized location use
            if let location = locationManager.location {
                selectedPlace = await Place(location: location)
                
            }
            // Setup a location callback - this handles when new location come in after the app launcher - it will catch the first locationUpdate which is what we need, otherwise we won;t see the information in the VSStack update after the user first authorizes location use
            locationManager.locationUpdated = {location in
                // We know we now have a new location, so use it to update the selectedPlace
                Task {
                    selectedPlace = await Place(location: location)
                }
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            PlaceLookupView(locationManager: locationManager, selectedPlace: $selectedPlace)
        }
        .buttonStyle(.borderedProminent)
        .font(.title2)
        
    }
}

#Preview {
    ContentView()
}
