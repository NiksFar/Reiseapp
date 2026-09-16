//
//  NewTripView.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//

import SwiftUI
import SwiftData

struct NewTripView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var tripFormViewModel = TripFormViewModel()
    @State private var addTraveler = false
    
    var body: some View {
        Form {
            ZStack {
                Text("Neue Reise")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.iconBG)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                    }
                }
            }
            .frame(height: 40)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            
            Section {
                Button {
                    //
                } label: {
                    HStack {
                        Image(systemName: "photo")
                        Text("Foto hinzufügen")
                    }
                }
                .foregroundStyle(.iconBG)
            }
            
            Section("Allgemeine Informationen") {
                TextField("Titel", text: $tripFormViewModel.title)
                TextField("Von", text: $tripFormViewModel.fromCity)
                TextField("Nach", text: $tripFormViewModel.toCity)
                DatePicker("Abreisedatum", selection: $tripFormViewModel.date, displayedComponents: .date)
            }
            
            Section("€ Finanzen") {
                VStack {
                    HStack {
                        Image(systemName: "ticket.fill")
                        TextField("Ticketpreis", text: $tripFormViewModel.ticketPrice)
                            .keyboardType(.decimalPad)
                        Spacer()
                        Text("pro Person")
                    }
                    HStack {
                        Text("Gesamt")
                        Text(
                            (Double(tripFormViewModel.ticketPrice) ?? 0) * Double(tripFormViewModel.travelers.count + 1),
                            format: .currency(code: "EUR")
                        )
                        Text("für \(tripFormViewModel.travelers.count + 1) Personen")
                    }
                    
                }
            }
            
            Section("Mitreisende") {
                Button {
                    addTraveler = true
                } label: {
                    HStack {
                        Text("Name Mitreisender")
                            .foregroundStyle(.gray)
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundStyle(.iconBG)
                    }
                }
                ForEach(tripFormViewModel.travelers) { traveler in
                    Text(traveler.name + " " + traveler.surname)
                    
                        .swipeActions(edge: .trailing) {
                            Button {
                                tripFormViewModel.removeTraveler(traveler: traveler)
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                }
            }
            
            Section {
                Button("Speichern") {
                    guard let trip = tripFormViewModel.createTrip() else { return }
                    modelContext.insert(trip)
                    do {
                        try modelContext.save()
                        dismiss()
                    } catch {
                       print(error.localizedDescription)
                    }
                }

                Button("Abbrechen") {
                    dismiss()
                }
            }
            
        }
        .padding(.vertical, -35)
        .sheet(isPresented: $addTraveler) {
            AddTravelerView(tripFormViewModel: tripFormViewModel)
        }
    }
    
}


#Preview {
    NewTripView()
}
