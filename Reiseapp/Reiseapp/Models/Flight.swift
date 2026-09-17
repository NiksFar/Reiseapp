//
//  Flight.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//
import Foundation

struct Flight: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var price: Double
}

struct SearchFlight {
    var fromCity: String
    var toCity: String
    var date: Date
}
