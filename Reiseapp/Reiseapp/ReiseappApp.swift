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
    var body: some Scene {
        WindowGroup {
            LoginView(loginViewModel: LoginViewModel())
        }
        .modelContainer(for: Trip.self)
    }
}
