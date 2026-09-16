//
//  Trip.swift
//  Reiseapp
//
//  Created by Mykyta on 16.09.26.
//

import Foundation
import SwiftData

@Model
class Trip {
    var title: String
    var fromCity: String
    var toCity: String
    var date: Date
    var ticketPrice: Double
    
    @Relationship(deleteRule: .cascade)
    var travelers: [Traveler] = []

    init(
        title: String,
        fromCity: String,
        toCity: String,
        date: Date,
        ticketPrice: Double,
        travelers: [Traveler]
    ) {
        self.title = title
        self.fromCity = fromCity
        self.toCity = toCity
        self.date = date
        self.ticketPrice = ticketPrice
        self.travelers = travelers
        
    }
}
