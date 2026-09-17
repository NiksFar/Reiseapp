//
//  FlightSearchViewModel.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//

import Foundation
import Observation

@Observable
class FlightSearchViewModel {
    
    var flights: [Flight] = []
    var fromCity: String = ""
    var toCity: String = ""
    var date: Date = Date()
    var isLoading: Bool = false
    
    private let repository: FlightRepository
    
    init(repository: FlightRepository) {
        self.repository = repository
    }
    
    func searchFlight() async {
        let search = SearchFlight(fromCity: fromCity, toCity: toCity, date: date)
        isLoading = true
        do {
            flights = try await repository.searchFlight(searchFlight: search)
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
}
