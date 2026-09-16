//
//  Traveler.swift
//  Reiseapp
//
//  Created by Mykyta on 16.09.26.
//

import Foundation
import SwiftData

@Model
class Traveler: Identifiable {
    
    var id: UUID = UUID()
    var name: String
    var surname: String
    
    init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
    
}

