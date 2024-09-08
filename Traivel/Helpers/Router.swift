//
//  Router.swift
//  Traivel
//
//  Created by Daria on 3.6.2024.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    public enum NavigationDestination: Hashable {
        case tripDetails(Trip)
        case newTripDetails(Trip)
        case tripList
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: NavigationDestination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
