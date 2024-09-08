//
//  BusinessCardItem.swift
//  Traivel
//
//  Created by Daria on 15.6.2024.
//

import SwiftUI

struct BusinessCardItem: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Dolce Penito Picante")
                    .font(.headline)
                Text("Addressing Street 22, Paris")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack {
                    ForEach(1..<6, id: \.self) { elem in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }.padding(.top, 5)
            }
            Spacer()
            CircleButton(size: .medium, image: "mappin.and.ellipse", action: {})
            
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    BusinessCardItem()
}
