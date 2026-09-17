//
//  ContentView.swift
//  Reiseapp
//
//  Created by Florian Rhein on 24.03.25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Reisen", systemImage: "suitcase.fill", value: 0) {
                MainView()
            }
            Tab("Flüge", systemImage: "airplane", value: 1) {
                Text("Flüge")
            }
            Tab("Wetter", systemImage: "cloud.sun.fill", value: 2) {
                WeatherView()
            }
            Tab("Einstellungen", systemImage: "gear", value: 3) {
                SettingsView()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
