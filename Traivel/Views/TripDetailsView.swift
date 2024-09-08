//
//  TripDetailsView.swift
//  Traivel
//
//  Created by Daria on 1.6.2024.
//

import SwiftUI
import MapKit
import SwiftData

struct TripDetailsView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var router: Router
    
    let trip: Trip
    let isNewTrip: Bool
    @State private var selectedDayIndex: Int? = 0
    // @State private var lastContentOffset: Int = 0
    
    func saveTrip() {
        modelContext.insert(trip)
        router.navigate(to: .tripList)
    }
    
    func deleteTrip() {
        modelContext.delete(trip)
        router.navigateBack()
    }
    
    func getDate(startDate: Date, dayIndex: Int) -> String {
        Calendar.current.date(byAdding: .day, value: dayIndex, to: startDate)!.formatted(date: .numeric, time: .omitted)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                ScrollView {
                    Map()
                        .frame(height: 300)
                        .cornerRadius(20)
                            //.padding(.top, lastContentOffset > 0 ? CGFloat(-lastContentOffset) : 0)
                            //.overlay(GeometryReader { geometry in
                            //    Color.clear
                    //        .onChange(of: geometry.frame(in: .global).minY) { newValue in
                    //            lastContentOffset = newValue > 0 ? Int(newValue) : 0
                    //          }
                    //      })
                   
                    VStack(spacing: 20) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(trip.getFullDestination())
                                    .font(.title).bold()
                                Text(String(trip.tripDays.count) + " days")
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            //CircleButton(size: .medium, image: "map", action: {})
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                        
                        VStack {
                            ForEach(trip.tripDays.indices, id: \.self) { index in
                                TripDayItem(tripDay: trip.tripDays[index], dayNumber: index + 1, date: getDate(startDate: trip.startDate, dayIndex: index), isOpen: selectedDayIndex == index)
                                    .onTapGesture {
                                        if (selectedDayIndex == index) {
                                            selectedDayIndex = nil
                                        } else {
                                            selectedDayIndex = index
                                        }
                                    }
                                    .sensoryFeedback(.increase, trigger: selectedDayIndex)
                            }
                        }
                        
                        
                        VStack {
                            HStack(alignment: .center) {
                                Text("Restaurants & Cafe")
                                    .font(.title3).bold()
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            BusinessCardItem()
                        }
                        
                        
                        VStack {
                            HStack(alignment: .center) {
                                Text("Participants")
                                    .font(.title3).bold()
                                Spacer()
                                CircleButton(size: .small, image: "plus", action: {})
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            
                            UserDetailsListItem(user: User(email: "test@email.con", username: "lovel", subscription: .basic))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        
                        
                    }
                    .padding()
                    .animation(.bouncy, value: selectedDayIndex)
                }
                
                if isNewTrip {
                    HStack {
                        Button(action: {
                            saveTrip()
                        }) {
                            HStack {
                                Image(systemName: "checkmark")
                                Text("Save trip")
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20).fill(.blue))
                        }
                        .buttonStyle(.plain)
                        .frame(width: .infinity)
                    }.padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .edgesIgnoringSafeArea([.top, .horizontal])
            .scrollIndicators(.hidden)
            HStack {
                CircleButton(size: .medium, image: "chevron.left", action: {
                    router.navigateBack()
                })
                Spacer()
                if !isNewTrip {
                    CircleButton(size: .medium, image: "trash", action: {
                        deleteTrip()
                    })
                }
            }
            .padding(.horizontal)
        }
        
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
        
        return TripDetailsView(trip: sampleTrip, isNewTrip: false)
}
