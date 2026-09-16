//
//  ReiseappApp.swift
//  Reiseapp
//
//  Created by Florian Rhein on 24.03.25.
//

import SwiftUI
import SwiftData

@main
struct ReiseappApp: App {
    @State private var loginViewModel = LoginViewModel()
    @AppStorage("darkMode") private var darkMode = false

    var body: some Scene {
        WindowGroup {
            Group {
                if loginViewModel.isLoggedIn {
                    ContentView()
                } else {
                    LoginView(loginViewModel: loginViewModel)
                }
            }
            .preferredColorScheme(darkMode ? .dark : .light)
        }
        .modelContainer(for: Trip.self)
    }
}
