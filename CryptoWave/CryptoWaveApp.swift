//
//  CryptoWaveApp.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 12/12/2023.
//

import SwiftUI

@main
struct CryptoWaveApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
