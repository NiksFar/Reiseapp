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

    var description: String {
        switch weatherCode {
        case 0:
            "Sonnig"
        case 1, 2:
            "Teilweise bewölkt"
        case 3:
            "Bewölkt"
        case 45, 48:
            "Nebel"
        case 51...57:
            "Nieselregen"
        case 61...67:
            "Regen"
        case 71...77:
            "Schnee"
        case 80...82:
            "Regenschauer"
        case 85, 86:
            "Schneeschauer"
        case 95:
            "Gewitter"
        case 96, 99:
            "Gewitter mit Hagel"
        default:
            "Unbekannt"
        }
    }

    var symbol: String {
        switch weatherCode {
        case 0:
            "sun.max.fill"
        case 1, 2:
            "cloud.sun.fill"
        case 3:
            "cloud.fill"
        case 45, 48:
            "cloud.fog.fill"
        case 51...67, 80...82:
            "cloud.rain.fill"
        case 71...77, 85, 86:
            "cloud.snow.fill"
        case 95, 96, 99:
            "cloud.bolt.rain.fill"
        default:
            "questionmark"
        }
    }
}
