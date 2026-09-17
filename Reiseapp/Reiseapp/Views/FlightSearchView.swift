//
//  FlightSearchView.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//

import SwiftUI
import SwiftData

struct FlightSearchView: View {
    
    @Query(sort: [SortDescriptor(\Trip.createdAt, order: .reverse)]) var trips: [Trip]
    @State private var flightSearchViewModel: FlightSearchViewModel
    @State private var fromCitySearch = ""
    @State private var toCitySearch = ""
    @State private var date = Date()
    
    init() {
        _flightSearchViewModel = State(
            initialValue: FlightSearchViewModel(
                repository: FlightAPIRepository() ))
    }
    
    var body: some View {
        ZStack{
            AppBackgroundView()
            
            VStack(spacing: 10) {
                
                Text("Günstigste Flüge")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 14)
                
                TextField("von", text: $fromCitySearch)
                    .formTextFieldStyle()
                TextField("nach", text: $toCitySearch)
                    .formTextFieldStyle()
                DatePicker("Ergebnisse ab dem", selection: $date, displayedComponents: .date)
                    .padding(.horizontal)
                    .frame(height: 70)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Button {
                    flightSearchViewModel.fromCity = fromCitySearch
                    flightSearchViewModel.toCity = toCitySearch
                    flightSearchViewModel.date = date
                    Task {
                        await flightSearchViewModel.searchFlight()
                    }
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Suchen")
                    }
                    .foregroundStyle(.iconBG)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Spacer()
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(flightSearchViewModel.flights) { flight in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(flight.date, format: .dateTime.day().month().year())
                                    
                                    Spacer()
                                    
                                    Text("\(flight.price, specifier: "%.0f") €")
                                        .fontWeight(.semibold)
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 16)
                                
                                Divider()
                            }
                        }
                    }
                }
                .frame(height: 250)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .offset(y: -25)
                Spacer()
            }
            .padding()
            
        }
        .task {
            if let lastTrip = trips.first {
                fromCitySearch = lastTrip.fromCity
                toCitySearch = lastTrip.toCity
                date = lastTrip.date
                
                flightSearchViewModel.fromCity = fromCitySearch
                flightSearchViewModel.toCity = toCitySearch
                flightSearchViewModel.date = date
                await flightSearchViewModel.searchFlight()
            }
        }
    }
}

#Preview {
    FlightSearchView()
}
