//
//  MockWeatherRepository.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//

import Foundation

struct MockWeatherRepository: WeatherRepository {
    
    func loadWeather(forCity: String) async throws -> Weather {
        let weather = Weather(temperature: 18.5, weatherCode: 0)
        return weather
    }
}
