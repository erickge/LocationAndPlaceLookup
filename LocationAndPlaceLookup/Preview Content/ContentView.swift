//
//  ContentView.swift
//  LocationAndPlaceLookup
//
//  Created by Gary Erickson on 5/27/25.
//

import SwiftUI

struct ContentView: View {
    @State var locationManager = LocationManager()
    @State private var sheetIsPresented: Bool = false
    
    var body: some View {
        VStack {
            
            Text("Hello, world from \(locationManager.location?.coordinate.longitude ?? 0.0), \(locationManager.location?.coordinate.latitude ?? 0.0) !")
            let _ = print("Hello, world from \(locationManager.location?.coordinate.longitude ?? 0.0), \(locationManager.location?.coordinate.latitude ?? 0.0) !")
        }
        Spacer()
        
        Button {
            sheetIsPresented.toggle()
            
        } label: {
            Image(systemName: "location.magnifyingglass")
            Text("LocationSearch")
            
        }
        .padding()
        .sheet(isPresented: $sheetIsPresented) {
            PlaceLookupView(locationManager: locationManager)
        }
        .buttonStyle(.borderedProminent)
        .font(.title2)
        
    }
}

#Preview {
    ContentView()
}
