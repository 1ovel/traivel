//
//  TripService.swift
//  Traivel
//
//  Created by Daria on 8.6.2024.
//

import Foundation

class TripService {
    private let baseURL: URL
    private let username: String
    private let password: String

    init() {
        self.baseURL = URL(string: "https://traivel-backend.onrender.com")!
        self.username = "user"
        self.password = "4ff5397cdad481f97b9cce381bae925d03d174270e7de68791fca05e48f835e1"
    }

    func generateTrip(numberOfDays: Int, country: Country, city: City, completion: @escaping (Result<[GeneratedTripDay], Error>) -> Void) {
        let countryName = country.name
        let cityName = city.name
        let endpoint = "/generate_trip"
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Encode credentials
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(NetworkError.encodingError))
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create JSON body
        let parameters: [String: Any] = [
            "numberOfDays": numberOfDays,
            "country": countryName,
            "city": cityName
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(NetworkError.invalidParameters))
            return
        }

        // Create data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                // Decode JSON to an array of TripDayDTO
                let decoder = JSONDecoder()
                let generatedTripDays = try decoder.decode([GeneratedTripDay].self, from: data)
                completion(.success(generatedTripDays))
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(.failure(NetworkError.noData))
            }
        }

        task.resume()
    }

    enum NetworkError: Error {
        case invalidURL
        case encodingError
        case invalidParameters
        case noData
    }
}
