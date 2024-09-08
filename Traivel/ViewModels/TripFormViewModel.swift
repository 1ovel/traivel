//
//  TripViewModel.swift
//  Traivel
//
//  Created by Daria on 30.5.2024.
//

import Foundation

class TripFormViewModel: ObservableObject {
    @Published var selectedCountry: Country? = nil
    @Published var selectedCity: City? = nil
    @Published var numberOfDays: Int = 1
    @Published var startingDate: Date = Date()
    private var tripService = TripService()

    func clearSelectedCountry() {
        self.selectedCountry = nil
        self.clearSelectedCity()
    }
    
    func clearSelectedCity() {
        self.selectedCity = nil
    }
    
    func decrementDay() {
        self.numberOfDays -= 1
    }
    
    func incrementDay() {
        self.numberOfDays += 1
    }
    
    func generateTrip(completion: @escaping (Result<[GeneratedTripDay], Error>) -> Void) {
        self.tripService.generateTrip(numberOfDays: self.numberOfDays, country: self.selectedCountry!, city: self.selectedCity!, completion: completion)
    }
}
