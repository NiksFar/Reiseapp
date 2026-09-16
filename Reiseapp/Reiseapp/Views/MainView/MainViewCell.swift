//
//  MainViewCell.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//

import SwiftUI
import UIKit

struct MainViewCell: View {
    
    let trip: Trip
    
    var body: some View {
        HStack(spacing: 10) {
            if let photoData = trip.photoData,
            let uiImage = UIImage(data: photoData) {
                Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                    .background(.yellow)
                    .clipShape(.circle)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(trip.title)
                    .font(.headline)
                Text(trip.toCity)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .italic()
                    
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MainViewCell(trip: Trip(title: "q", fromCity: "q", toCity: "s", date: Date(), ticketPrice: 20, travelers: []))
}
