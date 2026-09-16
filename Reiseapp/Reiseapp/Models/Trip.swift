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
    
    var photoData: Data?
    var title: String
    var fromCity: String
    var toCity: String
    var date: Date
    var createdAt = Date()
    var ticketPrice: Double
    
    @Relationship(deleteRule: .cascade)
    var travelers: [Traveler] = []

    init(
        photoData: Data? = nil,
        title: String,
        fromCity: String,
        toCity: String,
        date: Date,
        ticketPrice: Double,
        travelers: [Traveler]
    ) {
        self.photoData = photoData
        self.title = title
        self.fromCity = fromCity
        self.toCity = toCity
        self.date = date
        self.ticketPrice = ticketPrice
        self.travelers = travelers
    }
    
}
