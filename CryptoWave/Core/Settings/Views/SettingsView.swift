//
//  SettingsView.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 27/12/2023.
//

import SwiftUI

struct SettingsView: View {
        
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/@user-bj9ie5mq3x")!
    let coingeckoURL = URL(string: "https://www.coingecko.com/")!
    let linkedin = URL(string: "https://www.linkedin.com/in/islam-aldarabea-73978567/")!
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                List {
                    swiftjoSection
                        .listRowBackground(Color.theme.background.opacity(0.4))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.4))

                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.4))

                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.4))
                    
                }
            }
            .font(.headline)
            .accentColor(.blue)
                .listStyle(GroupedListStyle())
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        XMarkButton()
                    }
            }
            
        }
    }
}

#Preview {
    SettingsView()
}


extension SettingsView {
     
    private var swiftjoSection: some View {
        Section(header: Text("header")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
                Text("This app was made by Islam Aldarabea. it uses MVVM Architecture, Combine, and CoreData")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
                Text("The cryptocurrenccy data that is used in this app comes a free API from CoinGecko! Price may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit coinGecko 😍", destination: coingeckoURL)
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("IslamIMG")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120,height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
                Text("This app was developed by Islam Aldarabea. it uses SWiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Website 😇", destination: linkedin)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy of Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)

        }
    }
}
