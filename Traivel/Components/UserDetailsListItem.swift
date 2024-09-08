//
//  UserDetailsListItem.swift
//  Traivel
//
//  Created by Daria on 15.6.2024.
//

import SwiftUI

struct UserDetailsListItem: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: "person")
                .frame(width: 50, height: 50)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("@lovel1")
                Text(verbatim: "lovel@email.com")
                    .foregroundStyle(.secondary)
            }
        }.frame(width: .infinity, alignment: .leading)
    }
}

#Preview {
    UserDetailsListItem(user: User(email: "test@email.com", username: "lovel", subscription: .basic))
}
