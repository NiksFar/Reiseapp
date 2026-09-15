//
//  MainView.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackgroundView()
                
                VStack {
                    HStack {
                        Text("Meine Reisen")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    LazyVStack {
                        ForEach(1..<4) {_ in
                            
                            MainViewCell()
                            
                        }
                        
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
