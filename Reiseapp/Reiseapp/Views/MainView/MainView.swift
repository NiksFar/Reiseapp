//
//  MainView.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @Query(sort: [SortDescriptor(\Trip.createdAt, order: .reverse)]) var trips: [Trip]
    @State private var addNewVacation = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackgroundView()
                
                VStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.white)
                        
                        List {
                            ForEach(trips) { trip in
                                MainViewCell(trip: trip)
                                    .listRowBackground(Color.clear)
                                    .listRowInsets(EdgeInsets())
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                    .frame(height: CGFloat(trips.count) * 90)
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
