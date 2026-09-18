//
//  TripDetailViewModel.swift
//  Reiseapp
//
//  Created by Mykyta on 18.09.26.
//

import Foundation
import Observation

@Observable
class TripDetailViewModel {
    var weather: Weather?
    var flights: [Flight] = []
    var isLoading = false
    
    private let weatherRepository: WeatherRepository
    private let flightRepository: FlightRepository
    
    init(
        weatherRepository: WeatherRepository,
        flightRepository: FlightRepository
    ) {
        self.weatherRepository = weatherRepository
        self.flightRepository = flightRepository
    }
    
    func loadWeather(for city: String) async {
        isLoading = true
        
        do {
            weather = try await weatherRepository.loadWeather(forCity: city)
        } catch {
            print(error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func loadFlights(
        from fromCity: String,
        to toCity: String,
        date: Date
    ) async {
        let searchFlight = SearchFlight(
            fromCity: fromCity,
            toCity: toCity,
            date: date
        )

        do {
            flights = try await flightRepository.searchFlight(
                searchFlight: searchFlight
            )
        } catch {
            print("FLIGHT ERROR:", error)
        }
    }
}
