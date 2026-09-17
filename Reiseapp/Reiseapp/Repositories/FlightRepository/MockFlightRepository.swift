//
//  MockFlightRepository.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//

import Foundation

struct MockFlightRepository: FlightRepository {
    
    func searchFlight(searchFlight: SearchFlight) async throws -> [Flight] {
        let calendar = Calendar.current
        
        return [
            Flight(date: calendar.date(byAdding: .day, value: 1, to: searchFlight.date)!, price: 149),
            Flight(date: calendar.date(byAdding: .day, value: 2, to: searchFlight.date)!, price: 169),
            Flight(date: calendar.date(byAdding: .day, value: 3, to: searchFlight.date)!, price: 184),
            Flight(date: calendar.date(byAdding: .day, value: 4, to: searchFlight.date)!, price: 201),
            Flight(date: calendar.date(byAdding: .day, value: 5, to: searchFlight.date)!, price: 218),
            Flight(date: calendar.date(byAdding: .day, value: 6, to: searchFlight.date)!, price: 229),
            Flight(date: calendar.date(byAdding: .day, value: 7, to: searchFlight.date)!, price: 238),
            Flight(date: calendar.date(byAdding: .day, value: 8, to: searchFlight.date)!, price: 244),
            Flight(date: calendar.date(byAdding: .day, value: 9, to: searchFlight.date)!, price: 259),
            Flight(date: calendar.date(byAdding: .day, value: 10, to: searchFlight.date)!, price: 279)
        ]
    }
}
