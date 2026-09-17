//
//  WeatherViewModel.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//

import Foundation

@Observable
class WeatherViewModel {
    var weather: Weather?
    var selectedCity: String
    var isLoading: Bool

    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.weather = nil
        self.selectedCity = ""
        self.isLoading = false
        self.repository = repository
    }
    
    func loadWeather() async {
        isLoading = true
        do {
            let loadedWeather = try await repository.loadWeather(forCity: selectedCity)
            weather = loadedWeather
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false 
    }
    
}
