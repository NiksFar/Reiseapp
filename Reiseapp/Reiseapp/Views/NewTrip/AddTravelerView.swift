//
//  AddTravelerView.swift
//  Reiseapp
//
//  Created by Mykyta on 16.09.26.
//

import SwiftUI

struct AddTravelerView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var tripFormViewModel: TripFormViewModel
    @State var name = ""
    @State var surname = ""
    
    var body: some View {
        Form {
            TextField("Vorname", text: $name)
            TextField("Name", text: $surname)
            
            Section {
                Button("Hinzufügen") {
                    tripFormViewModel.addTraveler(name: name, surname: surname)
                    dismiss()
                }
                
                Button("Abbrechen") {
                    dismiss()
                }
                
            }
        }
    }
}

#Preview {
    AddTravelerView(tripFormViewModel: TripFormViewModel())
}
