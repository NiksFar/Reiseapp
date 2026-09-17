//
//  FlightRepository.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//

import Foundation

protocol FlightRepository {
    func searchFlight(searchFlight: SearchFlight) async throws -> [Flight]
}
