//
//  Flight.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//
import Foundation

struct Flight: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var price: Double
}

struct SearchFlight {
    var fromCity: String
    var toCity: String
    var date: Date
}

struct FlightAPIResponse: Codable {
    let bestFlights: [BestFlight]
    let otherFlights: [BestFlight]

    enum CodingKeys: String, CodingKey {
        case bestFlights = "best_flights"
        case otherFlights = "other_flights"
    }
}

struct BestFlight: Codable {
    let flights: [APIFlight]
    let price: Double
}

struct APIFlight: Codable {
    let departureAirport: Airport
    let arrivalAirport: Airport

    enum CodingKeys: String, CodingKey {
        case departureAirport = "departure_airport"
        case arrivalAirport = "arrival_airport"
    }
}

struct Airport: Codable {
    let time: String
}
