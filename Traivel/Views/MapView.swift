//
//  MapView.swift
//  Traivel
//
//  Created by Daria on 27.5.2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var text: String = ""
    let initialPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        ZStack {
            Map(initialPosition: initialPosition)
                .mapStyle(.standard(elevation: .realistic))
            TextField("Search", text: $text)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottomLeading)
                .padding()
        }
    }
}

#Preview {
    MapView()
}
