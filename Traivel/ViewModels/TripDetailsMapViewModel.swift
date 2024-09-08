//
//  TripDetailsMapViewModel.swift
//  Traivel
//
//  Created by Daria on 13.6.2024.
//

import Foundation
import MapKit
import Combine
import CoreLocation

class TripDetailsMapViewModel: ObservableObject {
    @Published var selectedDayIndex: Int = 0
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @Published var markers: [Marker] = []

    struct Marker: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
        let title: String
        let eventNumber: Int
    }

    func geocodeAddressesForEvents(events: [Event]) {
        let geocoder = CLGeocoder()
        var coordinates: [CLLocationCoordinate2D] = []
        var newMarkers: [Marker] = []
        let geocodeGroup = DispatchGroup()

        for index in events.indices {
            let event = events[index]
            geocodeGroup.enter()
            geocoder.geocodeAddressString(event.address) { (placemarks, error) in
                if let placemark = placemarks?.first, let location = placemark.location {
                    let marker = Marker(
                        coordinate: location.coordinate,
                        title: event.title,
                        eventNumber: index + 1
                    )
                    newMarkers.append(marker)
                    coordinates.append(location.coordinate)
                }
                geocodeGroup.leave()
            }
        }
        

        geocodeGroup.notify(queue: .main) {
            print(newMarkers)
            self.markers = newMarkers
            self.updateRegion(for: coordinates)
        }
    }
    
    private func updateRegion(for coordinates: [CLLocationCoordinate2D]) {
        guard !coordinates.isEmpty else { return }

        var minLat = coordinates[0].latitude
        var maxLat = coordinates[0].latitude
        var minLon = coordinates[0].longitude
        var maxLon = coordinates[0].longitude

        for coordinate in coordinates {
            if coordinate.latitude < minLat {
                minLat = coordinate.latitude
            }
            if coordinate.latitude > maxLat {
                maxLat = coordinate.latitude
            }
            if coordinate.longitude < minLon {
                minLon = coordinate.longitude
            }
            if coordinate.longitude > maxLon {
                maxLon = coordinate.longitude
            }
        }

        let centerLat = (minLat + maxLat) / 2
        let centerLon = (minLon + maxLon) / 2

        let spanLat = (maxLat - minLat) * 1.2 // Adding some padding
        let spanLon = (maxLon - minLon) * 1.2 // Adding some padding

        let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
        let span = MKCoordinateSpan(latitudeDelta: spanLat, longitudeDelta: spanLon)

        self.region = MKCoordinateRegion(center: center, span: span)
    }
}
