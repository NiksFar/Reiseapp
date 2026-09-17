//
//  Weather.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//

import Foundation

struct City: Decodable {
    let name: String
    let latitude: Double
    let longitude: Double
}

struct CityResponse: Decodable {
    let results: [City]
}

struct Current: Codable {
    let time: String
    let temperature2M: Double
    let weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case time = "time"
        case temperature2M = "temperature_2m"
        case weatherCode = "weather_code"
    }
}

struct WeatherResponse: Decodable {
    let current: Current
}

struct Weather {
    let temperature: Double
    let weatherCode: Int
}
