//
//  WeatherRepository.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//

import Foundation

protocol WeatherRepository {
    
    func loadWeather(forCity: String) async throws -> Weather
    
}
