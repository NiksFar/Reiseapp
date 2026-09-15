//
//  MainViewCell.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//

import SwiftUI

struct MainViewCell: View {
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)
                .background(.yellow)
                .clipShape(.circle)

            VStack(alignment: .leading, spacing: 5) {
                Text("Familienurlaub")
                    .font(.headline)
                Text("Kroatien")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .italic()
                    
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MainViewCell()
}
