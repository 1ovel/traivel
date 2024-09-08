//
//  User.swift
//  Traivel
//
//  Created by Daria on 30.5.2024.
//

import Foundation
import SwiftData

@Model
class User: Identifiable, Hashable {
    @Attribute(.unique) var id: String
    var email: String
    var username: String
    var subscription: Subscription
    
    init(email: String, username: String, subscription: Subscription) {
        self.id = UUID().uuidString
        self.username = username
        self.email = email
        self.subscription = subscription
    }
}

enum Subscription: String, CaseIterable, Codable {
    case basic = "Basic"
    case plus = "Plus"
}
