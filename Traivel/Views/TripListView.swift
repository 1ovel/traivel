//
//  TripListView.swift
//  Traivel
//
//  Created by Daria on 29.5.2024.
//

import SwiftUI
import SwiftData

struct TripListView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var router: Router
    @Query var trips: [Trip]
    
    var body: some View {
            ScrollView {
                HStack {
                    Text("Upcoming trips")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding([.top, .horizontal])
                
                VStack(spacing: 15) {
                    ForEach(trips) { trip in
                        TripListItem(trip: trip)
                            .onTapGesture {
                                router.navigate(to: .tripDetails(trip))
                            }
                    }
                }
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
            }
    }
}

#Preview {
    TripListView()
}

