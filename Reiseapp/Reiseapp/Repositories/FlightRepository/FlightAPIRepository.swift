//
//  FlightAPIRepository.swift
//  Reiseapp
//
//  Created by Mykyta on 18.09.26.
//

import Foundation

struct FlightAPIRepository: FlightRepository {
    
    private let cityToIATA: [String: String] = [
            "Berlin": "BER",
            "London": "LHR",
            "Paris": "CDG",
            "Madrid": "MAD",
            "Rome": "FCO",
            "Vienna": "VIE",
            "Amsterdam": "AMS",
            "Prague": "PRG",
            "Barcelona": "BCN",
            "Lisbon": "LIS"
        ]
    
    func searchFlight(searchFlight: SearchFlight) async throws -> [Flight] {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "serpapi.com"
        components.path = "/search"
        
        guard let departureID = cityToIATA[searchFlight.fromCity],
              let arrivalID = cityToIATA[searchFlight.toCity] else {
            throw URLError(.resourceUnavailable)
        }
        
        let requestDateFormatter = DateFormatter()
        requestDateFormatter.dateFormat = "yyyy-MM-dd"
        requestDateFormatter.locale = Locale(identifier: "en_US_POSIX")

        let outboundDate = requestDateFormatter.string(from: searchFlight.date)

        let responseDateFormatter = DateFormatter()
        responseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        responseDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        components.queryItems = [
            URLQueryItem(name: "engine", value: "google_flights"),
            URLQueryItem(name: "api_key", value: ApiKey.apiKey),
            URLQueryItem(name: "departure_id", value: departureID),
            URLQueryItem(name: "arrival_id", value: arrivalID),
            URLQueryItem(name: "outbound_date", value: outboundDate),
            URLQueryItem(name: "type", value: "2"),
            URLQueryItem(name: "currency", value: "EUR")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let result = try JSONDecoder().decode(
            FlightAPIResponse.self,
            from: data
        )
        
        
        
        let allFlights = result.bestFlights + result.otherFlights
        
        let flights = allFlights.compactMap { bestFlight -> Flight? in
            
            guard let firstFlight = bestFlight.flights.first,
                  let date = responseDateFormatter.date(
                    from: firstFlight.departureAirport.time
                  ) else {
                return nil
            }
            
            return Flight(
                date: date,
                price: bestFlight.price
            )
        }
        
        return Array(flights.prefix(10))
    }
}
