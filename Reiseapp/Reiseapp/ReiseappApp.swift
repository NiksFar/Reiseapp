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

    var body: some Scene {
        WindowGroup {
            if loginViewModel.isLoggedIn {
                MainView()
            } else {
                LoginView(loginViewModel: loginViewModel)
            }
        }
        .modelContainer(for: Trip.self)
    }
}
