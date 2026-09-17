//
//  SearchTextFieldModifier.swift
//  Reiseapp
//
//  Created by Mykyta on 17.09.26.
//
import SwiftUI

struct SearchTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.horizontal)
            .frame(height: 50)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension View {
    func formTextFieldStyle() -> some View {
        modifier(SearchTextFieldModifier())
    }
}
