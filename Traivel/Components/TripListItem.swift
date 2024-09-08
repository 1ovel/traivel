//
//  TripListItem.swift
//  Traivel
//
//  Created by Daria on 29.5.2024.
//

import SwiftUI

struct TripListItem: View {
    let trip: Trip
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "airplane")
                .frame(width: 36, height: 36)
                .background(Color.accentColor)
                .mask(Circle())
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing: 4) {
                Text(trip.getFullDestination())
                    .fontWeight(.semibold)
                Text(String(trip.tripDays.count) + " days")
            }
            Spacer()
            Text(trip.startDate.formatted(date: .numeric, time: .omitted))
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                .foregroundColor(.secondary)
        }
        .padding()
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
        
        return TripListItem(trip: sampleTrip)
}
