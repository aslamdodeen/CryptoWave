//
//  CryptoWaveApp.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 12/12/2023.
//

import SwiftUI

@main
struct CryptoWaveApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
