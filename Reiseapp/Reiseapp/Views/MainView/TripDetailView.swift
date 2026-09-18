//
//  TripDetailView.swift
//  Reiseapp
//
//  Created by Mykyta on 18.09.26.
//

import SwiftUI

struct TripDetailView: View {
    
    var trip: Trip
    @State private var tripDetailViewModel: TripDetailViewModel
    
    init(trip: Trip) {
        self.trip = trip
        _tripDetailViewModel = State(
            initialValue: TripDetailViewModel(
                weatherRepository: WeatherAPIRepository(),
                flightRepository: MockFlightRepository()
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackgroundView()
                
                Form {
                    
                    Section {
                        Text(trip.toCity)
                        Text(trip.date, format: .dateTime.day().month().year())
                    }
                    
                    
                    Section {
                        if tripDetailViewModel.isLoading {
                            ProgressView()
                        } else if let weather = tripDetailViewModel.weather {
                            HStack {
                                Image(systemName: weather.symbol)
                                Spacer()
                                
                                Text(weather.description)
                                .font(.callout)
                                
                                Text("\(weather.temperature, specifier: "%.1f") °C")
                                        .font(.headline)
                            }
                        }
                    } header: {
                        Text("Wetter")
                    }
                    
                    Section {
                        ForEach(tripDetailViewModel.flights) { flight in
                            HStack {
                                Text(flight.date, format: .dateTime.day().month().year())
                                Spacer()
                                Text("\(flight.price, specifier: "%.0f") €")
                                    .fontWeight(.semibold)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                        }
                    } header: {
                        Text("Günstigste Flüge")
                    }
                    
                    
                }
                .scrollContentBackground(.hidden)
                
            }
            .task {
                await tripDetailViewModel.loadWeather(for: trip.toCity)
                await tripDetailViewModel.loadFlights(from: trip.fromCity, to: trip.toCity, date: trip.date)
            }
            .navigationTitle(trip.title)
            
        }
    }
}


#Preview {
    TripDetailView(trip: Trip(title: "Urlaub", fromCity: "Berlin", toCity: "Paris", date: Date(), ticketPrice: 100, travelers: []))
}
