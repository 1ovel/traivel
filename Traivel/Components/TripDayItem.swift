//
//  TripDayPage.swift
//  Traivel
//
//  Created by Daria on 9.6.2024.
//

import SwiftUI

struct TripDayItem: View {
    let tripDay: TripDay
    let dayNumber: Int
    let date: String
    var isOpen: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Day " + String(dayNumber))
                    .bold()
                Spacer()
                Text(date)
                    .foregroundStyle(.secondary)
                Image(systemName: "chevron.up")
                    .rotationEffect(.degrees(isOpen ? 0 : 180))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if isOpen {
                VStack {
                    ForEach(tripDay.events.indices, id: \.self) { index in
                        EventItem(event: tripDay.events[index], eventNumber: index + 1)
                    }
                }
            }
            
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .animation(.bouncy, value: isOpen)
        
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
        
        let sampleTripDay = TripDay(dayNumber: 1, events: sampleEvents)
        
    return TripDayItem(tripDay: sampleTripDay, dayNumber: 1, date: "21.06.2024", isOpen: true)
}
