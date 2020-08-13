//
//  ContentView.swift
//  SmartCart
//
//  Created by Jan Scheithauer on 12.08.20.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    @ObservedObject var locationManager: LocationManager

    init() {
        self.locationManager = LocationManager()
        self.locationManager.onAuthorizationStatusDenied = {
            print("Access Denied")
        }

        let geofenceRegionCenter = CLLocationCoordinate2DMake(47.6506, 9.1733)
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter,
                                              radius: 20,
                                              identifier: "UniqueIdentifier")
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        self.locationManager.startMonitoring(for: [geofenceRegion])
    }

    var body: some View {
        switch self.locationManager.regionState {
        case .enter(region: _):
            Text("Enter").padding()
        case .leave(region: _):
            Text("Leave").padding()
        case .none:
            Text("None").padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
