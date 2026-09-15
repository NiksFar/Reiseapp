//
//  AppBackgroundView.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//

import SwiftUI

struct AppBackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [.yellow, .purple],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

#Preview {
    AppBackgroundView()
}
