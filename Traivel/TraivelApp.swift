//
//  TraivelApp.swift
//  Traivel
//
//  Created by Daria on 27.5.2024.
//

import SwiftUI
import SwiftData

@main
struct TraivelApp: App {
    let container = try! ModelContainer(for: Trip.self, User.self)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
