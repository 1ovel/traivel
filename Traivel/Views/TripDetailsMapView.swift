//
//  TripDetailsMapView.swift
//  Traivel
//
//  Created by Daria on 13.6.2024.
//

import SwiftUI
import MapKit

struct TripDetailsMapView: View {
    let trip: Trip
    @ObservedObject var viewModel = TripDetailsMapViewModel()
    
    var body: some View {
        Map(initialPosition: MapCameraPosition.region(viewModel.region)) {
            ForEach(viewModel.markers) { marker in
                Marker(marker.title, coordinate: marker.coordinate)
            }
        }
            .mapStyle(.standard(elevation: .realistic))
            .onAppear {
                viewModel.geocodeAddressesForEvents(events: trip.tripDays[viewModel.selectedDayIndex].events)
            }
            .cornerRadius(20)
    }
}

#Preview {
    let sampleEvents = [
            Event(
                title: "Visit Eiffel Tower",
                details: "Experience the beauty of the Eiffel Tower with a guided tour.",
                country: "France",
                city: "Paris",
                address: "Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France",
                tickets: "https://tickets.eiffeltower.com"
            ),
            Event(
                title: "Louvre Museum",
                details: "Explore the world's largest art museum and a historic monument in Paris.",
                country: "France",
                city: "Paris",
                address: "Rue de Rivoli, 75001 Paris, France",
                tickets: "https://tickets.louvre.fr"
            )
        ]
    
    let sampleEvents2 = [
            Event(
                title: "Visit Eiffel Tower",
                details: "Experience the beauty of the Eiffel Tower with a guided tour.",
                country: "France",
                city: "Paris",
                address: "Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France",
                tickets: "https://tickets.eiffeltower.com"
            ),
            Event(
                title: "Louvre Museum",
                details: "Explore the world's largest art museum and a historic monument in Paris.",
                country: "France",
                city: "Paris",
                address: "Rue de Rivoli, 75001 Paris, France",
                tickets: "https://tickets.louvre.fr"
            ),
            Event(
                title: "Louvre Museum",
                details: "Explore the world's largest art museum and a historic monument in Paris.",
                country: "France",
                city: "Paris",
                address: "Rue de Rivoli, 75001 Paris, France",
                tickets: "https://tickets.louvre.fr"
            ),
            Event(
                title: "Louvre Museum",
                details: "Explore the world's largest art museum and a historic monument in Paris.",
                country: "France",
                city: "Paris",
                address: "Rue de Rivoli, 75001 Paris, France",
                tickets: "https://tickets.louvre.fr"
            )
        ]
        
        let sampleTripDay1 = TripDay(dayNumber: 1, events: sampleEvents)
        let sampleTripDay2 = TripDay(dayNumber: 2, events: sampleEvents2)
        let sampleTripDays = [sampleTripDay1, sampleTripDay2, sampleTripDay1, sampleTripDay2]
        let sampleParticipant = User(email: "John Doe", username: "lovel", subscription: .basic)
    let sampleTrip = Trip(startDate: Date(), participantIds: [sampleParticipant.id], tripDays: sampleTripDays)

        
        
    return TripDetailsMapView(trip: sampleTrip)
}
