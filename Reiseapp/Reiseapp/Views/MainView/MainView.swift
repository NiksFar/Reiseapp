//
//  MainView.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//

import SwiftUI

struct MainView: View {
    
    @State private var addNewVacation = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackgroundView()
                
                VStack {
                    
                    LazyVStack {
                        ForEach(1..<4) {_ in
                            MainViewCell()
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
