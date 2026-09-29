//
//  WeatherView.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//

import SwiftUI
import SwiftData

struct WeatherView: View {
    
    @Query(sort: [SortDescriptor(\Trip.createdAt, order: .reverse)]) var trips: [Trip]
    @State private var weatherViewModel: WeatherViewModel
    @State private var searchCity = ""
    
    init() {
        _weatherViewModel = State(
            initialValue: WeatherViewModel(
                repository: WeatherAPIRepository() ))
    }
    
    private var weatherSymbol: String {
        guard let weatherCode = weatherViewModel.weather?.weatherCode else {
            return "cloud"
        }
        switch weatherCode {
        case 0:
            return "sun.max.fill"
        case 1, 2:
            return "cloud.sun.fill"
        case 3:
            return "cloud.fill"
        case 45, 48:
            return "cloud.fog.fill"
        case 51...67:
            return "cloud.rain.fill"
        case 71...77:
            return "cloud.snow.fill"
        case 80...82:
            return "cloud.heavyrain.fill"
        case 85, 86:
            return "cloud.snow.fill"
        case 95, 96, 99:
            return "cloud.bolt.rain.fill"
        default:
            return "cloud"
        }
    }
    
    var body: some View {
        ZStack {
            AppBackgroundView()
            
            VStack {
                ZStack {
                    TextField("Ort", text: $searchCity)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal)
                        .frame(height: 50)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    HStack {
                        Spacer()
                        Button {
                            weatherViewModel.selectedCity = searchCity
                            Task {
                                await weatherViewModel.loadWeather()
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                    .padding()
                }
                Spacer()
                // UI
                Image(systemName: weatherSymbol)
                    .font(.system(size: 230))
                    .foregroundStyle(.white)
                
                Spacer()
                
                if let weather = weatherViewModel.weather {
                    Text("\(weather.temperature, specifier: "%.0f")°C")
                        .font(.system(size: 120))
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
            .padding()
        }
        .task {
            if let lastTrip = trips.first {
                searchCity = lastTrip.toCity
                weatherViewModel.selectedCity = searchCity
                await weatherViewModel.loadWeather()
            }
        }
    }
}

#Preview {
    WeatherView()
}
