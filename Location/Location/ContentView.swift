//
//  ContentView.swift
//  Location
//
//  Created by Haadhya on 30/12/23.
//

import SwiftUI
import CoreLocation

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    var authorizationStatusCallback: ((CLAuthorizationStatus) -> Void)?

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            guard let callback = self.authorizationStatusCallback else { return }
            let status = CLLocationManager.authorizationStatus()
            callback(status)
        }
    }
}

struct ContentView: View {
    @State private var locationManager = CLLocationManager()
    @State private var authorizationStatus: CLAuthorizationStatus?

    var body: some View {
        VStack {
            // Your app content goes here
        }
        .onAppear {
            requestLocationPermission()
        }
    }

    func requestLocationPermission() {
        let delegate = LocationManagerDelegate()
        delegate.authorizationStatusCallback = { status in
            handleAuthorizationStatus(status)
        }

        locationManager.delegate = delegate

        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                default:
                    // For other cases, wait for the delegate callback
                    break
                }
            } else {
                // Location services are not enabled
                // You can guide the user to enable location services in settings
            }
        }
    }

    func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        authorizationStatus = status

        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Location permission granted, you can start using location services
            break
        case .denied, .restricted:
            // Handle denied or restricted access
            break
        default:
            break
        }
    }
}
#Preview {
    ContentView()
}
