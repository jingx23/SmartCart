//
//  LocationManager.swift
//  SmartCart
//
//  Created by Jan Scheithauer on 13.08.20.
//

import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private var regions: [CLRegion] = []
    private let manager: CLLocationManager = CLLocationManager()

    public var onAuthorizationStatusDenied: () -> Void = { assertionFailure("not defined onAuthorizationStatusDenied block") }

    public let monitoredRegionChange = PassthroughSubject<MonitoredRegionState?, Never>()

    @Published private(set) var regionState: MonitoredRegionState? {
        willSet {
            monitoredRegionChange.send(regionState)
        }
    }

    override init() {
        super.init()
        self.manager.delegate = self
    }

    func startMonitoring(for regions: [CLRegion]) {
        self.requestPermission()
        self.stopMonitoring()
        self.regions = regions
        self.regions.forEach { region in
            self.manager.startMonitoring(for: region)
        }
        self.manager.requestLocation()
    }

    func stopMonitoring() {
        self.regions.forEach { region in
            self.manager.stopMonitoring(for: region)
        }
    }

    func requestPermission() {
        if self.manager.authorizationStatus() == CLAuthorizationStatus.denied {
            onAuthorizationStatusDenied()
        } else {
            self.manager.requestAlwaysAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    // called when user Enters a monitored region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            //self.handleEvent(forRegion: region)
            print("enter \(region)")
            self.regionState = .enter(region: region)
        }
    }

    // called when user Exits a monitored region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            //self.handleEvent(forRegion: region)
            print("leave \(region)")
            self.regionState = .leave(region: region)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdate")
    }

}

enum MonitoredRegionState {
    case enter(region: CLRegion)
    case leave(region: CLRegion)
}
