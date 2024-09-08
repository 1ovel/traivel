//
//  MainView.swift
//  Traivel
//
//  Created by Daria on 19.6.2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State var selectedTab: mainViewTab = .home
    @Query var trips: [Trip]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TripDetailsMapView(trip: trips[0])
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(mainViewTab.home)
            TripFormView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("New trip")
                }
                .tag(mainViewTab.tripForm)
            TripListView()
                .tabItem {
                    Image(systemName: "airplane.departure")
                    Text("My trips")
                }
                .tag(mainViewTab.tripList)
        }
    }
}

enum mainViewTab {
    case home
    case tripForm
    case tripList
}

#Preview {
    return MainView(selectedTab: .home)
}
