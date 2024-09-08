

import Foundation
import SwiftData

@Model
class Trip: Identifiable, Hashable {
    @Attribute(.unique) var id: String
    var startDate: Date
    var participantIds: [String]
    var tripDays: [TripDay]
    var status: TripStatus
    
    init(startDate: Date, participantId: String, tripDays: [TripDay]) {
            self.id = UUID().uuidString
            self.startDate = startDate
            self.participantIds = [participantId]
            self.tripDays = tripDays
            self.status = TripStatus.notStarted
    }
    
    init(startDate: Date, participantIds: [String], tripDays: [TripDay]) {
            self.id = UUID().uuidString
            self.startDate = startDate
            self.participantIds = participantIds
            self.tripDays = tripDays
            self.status = TripStatus.notStarted
    }
    
    func getFullDestination() -> String {
        return self.tripDays[0].events[0].country + ", " + self.tripDays[0].events[0].city
    }

}

enum TripStatus: String, CaseIterable, Hashable, Codable {
    case notStarted = "NotStarted"
    case inProgress = "InProgress"
    case finished = "Finished"
}

struct TripDay: Hashable, Codable {
    var dayNumber: Int
    var events: [Event]
    
    init(dayNumber: Int, events: [Event]) {
        self.dayNumber = dayNumber
        self.events = events
    }
}

struct Event: Hashable, Codable {
    let id: String
    var title: String
    var details: String
    var country: String
    var city: String
    var address: String
    var tickets: String
    
    init(title: String, details: String, country: String, city: String, address: String, tickets: String) {
        self.id = UUID().uuidString
        self.title = title
        self.details = details
        self.country = country
        self.city = city
        self.address = address
        self.tickets = tickets
    }
}

struct GeneratedTripDay: Codable, Hashable {
    let events: [GeneratedEvent]
    
    struct GeneratedEvent: Codable, Hashable {
        let title: String
        let details: String
        let address: String
        let country: String
        let city: String
        let tickets: String
    }
}

func createTripFromGeneratedTripDays(from generatedTripDays: [GeneratedTripDay], startDate: Date, participantIds: [String]) -> Trip {
    let tripDays = generatedTripDays.enumerated().map { (index, generatedTripDay) -> TripDay in
        let events = generatedTripDay.events.map { generatedEvent -> Event in
            return Event(
                title: generatedEvent.title,
                details: generatedEvent.details,
                country: generatedEvent.country,
                city: generatedEvent.city,
                address: generatedEvent.address,
                tickets: generatedEvent.tickets
            )
        }
        return TripDay(dayNumber: index + 1, events: events)
    }
    
    return Trip(startDate: startDate, participantIds: participantIds, tripDays: tripDays)
}
