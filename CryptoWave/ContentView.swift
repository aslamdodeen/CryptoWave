//
//  ContentView.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 12/12/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack {
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Secondary")
                    .foregroundColor(Color.theme.secondaryText)

                Text("red color")
                    .foregroundColor(Color.theme.red)

                Text("Green color")
                    .foregroundColor(Color.theme.green)


            }
            .font(.title)
        }
    }
}

#Preview {
    ContentView()
}
