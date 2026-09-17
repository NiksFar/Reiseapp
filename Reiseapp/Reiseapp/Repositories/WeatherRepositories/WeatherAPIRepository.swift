//
//  WeatherAPIRepository.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//
import Foundation

struct WeatherAPIRepository: WeatherRepository {
    
    private func getCity(city: String) async throws -> City {
        guard let url = URL(string: "https://geocoding-api.open-meteo.com/v1/search?name="+"\(city)"+"&count=1&language=en&format=json") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(CityResponse.self, from: data)
        guard let city = result.results.first else {
            throw URLError(.resourceUnavailable)
        }
        return city
    }
    
    private func getWeather(latitude: Double, longitude: Double) async throws -> Weather {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude="+"\(latitude)"+"&longitude="+"\(longitude)"+"&current=temperature_2m,weather_code") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(WeatherResponse.self, from: data)
        let forecast = Weather(temperature: result.current.temperature2M,
                                     weatherCode: result.current.weatherCode)
        return forecast
    }
    
    func loadWeather(forCity: String) async throws -> Weather {
        let city = try await getCity(city: forCity)
        let forecast = try await getWeather(latitude: city.latitude, longitude: city.longitude)
        return forecast
    }
    
}
