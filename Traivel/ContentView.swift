//
//  ContentView.swift
//  Traivel
//
//  Created by Daria on 27.5.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            MainView()
            .navigationDestination(for: Router.NavigationDestination.self) { navigationDestination in
                switch navigationDestination {
                case .newTripDetails(let trip):
                    TripDetailsView(trip: trip, isNewTrip: true)
                        .navigationBarBackButtonHidden()
                case .tripDetails(let trip):
                    TripDetailsView(trip: trip, isNewTrip: false)
                        .navigationBarBackButtonHidden()
                case .tripList:
                    MainView(selectedTab: .tripList)
                        .navigationBarBackButtonHidden()
                }
            
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}
