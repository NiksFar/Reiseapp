//
//  SettingsView.swift
//  Reiseapp
//
//  Created by Mykyta on 16.09.26.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("darkMode") private var darkMode = false
    @Environment(\.openURL) private var openURL
    @State private var abreiseortTF = ""
    @State private var benutzerdaten = false
    
    var body: some View {
        NavigationStack {
            Form {
                // Persönliche Einstellungen
                Section {
                    TextField("Abreiseort", text: $abreiseortTF)
                    
                    Toggle(isOn: $darkMode) {
                        Text("Dunkelmodus")
                    }
                    .tint(.iconBG)
                    
                    Toggle(isOn: $benutzerdaten) {
                        Text("Senden der Benutzerdaten")
                    }
                    .tint(.iconBG)
                } header: {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("Persönliche Einstellungen")
                    }
                } footer: {
                    Text("Ihre Benutzerdaten werden anonymisiert verarbeitet, um die Qualität von TravelMate stets verbessern zu können.")
                }
                
                //Hilfe
                Section {
                    Button {
                        openURL(URL(string: "https://www.google.de")!)
                    } label: {
                        HStack{
                            Image(systemName: "globe")
                            Text("Hilfe-Forum")
                        }
                        .foregroundStyle(.iconBG)
                    }
                    
                    Button {
                        openURL(URL(string: "tel:+4912345")!)
                    } label: {
                        HStack{
                            Image(systemName: "phone")
                            Text("Hotline")
                        }
                        .foregroundStyle(.iconBG)
                    }
                } header: {
                    HStack{
                        Image(systemName: "questionmark.circle.fill")
                        Text("Hilfe")
                    }
                } footer: {
                    Text("Unsere Hotline erreichen Sie Mo-Mi 9:00-13:30")
                }
                
            }
            .navigationTitle("Einstellungen")
        }
    }
}

#Preview {
    SettingsView()
}
