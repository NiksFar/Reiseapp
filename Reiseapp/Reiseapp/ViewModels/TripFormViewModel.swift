//
//  TripFormViewModel.swift
//  Reiseapp
//
//  Created by Mykyta on 16.09.26.
//
import Observation
import Foundation

@Observable
class TripFormViewModel {
    
    var photoData: Data? = nil
    var title = ""
    var fromCity = ""
    var toCity = ""
    var date = Date()
    var ticketPrice = ""
    var travelers: [Traveler] = []
    
    func addTraveler(name: String, surname: String) {
        let traveler = Traveler(name: name, surname: surname)
        travelers.append(traveler)
    }
    
    func createTrip() -> Trip? {
        let ticketPrice = Double(ticketPrice) ?? 0
        
        let trip = Trip(photoData: photoData, title: title, fromCity: fromCity, toCity: toCity, date: date, ticketPrice: ticketPrice, travelers: travelers)
        return trip
    }
    
    func removeTraveler(traveler: Traveler) {
        guard let index = travelers.firstIndex(where: {$0.id == traveler.id}) else { return }
        travelers.remove(at: index)
    }
    
}
