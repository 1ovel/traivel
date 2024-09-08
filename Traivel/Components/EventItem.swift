//
//  EventItem.swift
//  Traivel
//
//  Created by Daria on 1.6.2024.
//

import SwiftUI

struct EventItem: View {
    var event: Event
    var eventNumber: Int
    
    var body: some View {
        
            HStack(alignment: .center) {
                Text(String(eventNumber))
                    .padding(.trailing, 8)
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .bold()
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(event.title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 5)
                    }
                    Text(event.details)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true) // This allows the text to expand vertically
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
    }
}

#Preview {
    let sampleEvent = Event(
        title: "Visit Eiffel Tower",
        details: "Experience the beauty of the Eiffel Tower with a guided tour.",
        country: "France",
        city: "Paris",
        address: "Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France",
        tickets: "https://tickets.eiffeltower.com"
    )
    return EventItem(event: sampleEvent, eventNumber: 1)
}
