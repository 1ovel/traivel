//
//  DestinationSerivce.swift
//  Traivel
//
//  Created by Daria on 31.5.2024.
//

import Foundation

class DestinationSerivce: ObservableObject {
    @Published var countries: [Country] = []
    @Published var cities: [City] = []
    
    init() {
        self.countries = getCountries()
    }
    
    func getCountries() -> [Country] {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            return []
        }
        
        guard let data = try? Data(contentsOf: url),
              let decodedCountries = try? JSONDecoder().decode([Country].self, from: data) else {
                return []
        }

        return decodedCountries
                
    }
    
    func getCitiesForCountry(country: Country?) -> [City] {
        if country == nil {
            return []
        }
        
        let allCities = self.getCities()
        let filteredCities = allCities.filter { $0.country == country!.code }
        
        return filteredCities
    }
    
    func getCities() -> [City] {
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json") else {
            return []
        }
        
        guard let data = try? Data(contentsOf: url),
              let decodedCities = try? JSONDecoder().decode([City].self, from: data) else {
                return []
        }

        return decodedCities
    }
    
    func getCountryFlag(countryCode: String) -> String {
        countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    func onCountriesFiltering(prompt: String, countries: [Country]) -> [Country] {
        return Array(countries.filter { $0.name.contains(prompt) }.prefix(5))
    }
    
    func onCitiesFiltering(prompt: String, cities: [City]) -> [City] {
        return Array(cities.filter { $0.name.contains(prompt) }.prefix(5))
    }
    
    func generateCountryLabel(country: Country) -> String {
        let result = self.getCountryFlag(countryCode: country.code) + " " + country.name
        return result
    }
    
    func generateCityLabel(city: City) -> String {
        return city.name
    }

}
