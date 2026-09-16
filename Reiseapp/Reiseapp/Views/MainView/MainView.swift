//
//  MainView.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @Query private var trips: [Trip]
    @State private var addNewVacation = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackgroundView()
                
                VStack {
                    
                    LazyVStack {
                        ForEach(trips) { trip in
                            MainViewCell(trip: trip)
                        }
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .navigationTitle("Meine Reisen")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addNewVacation = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
        }
        .sheet(isPresented: $addNewVacation) {
            NewTripView()
        }
    }
}

#Preview {
    MainView()
}
