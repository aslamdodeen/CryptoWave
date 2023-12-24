//
//  DetailView.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 23/12/2023.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding  var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
       
    }
}

struct DetailView: View {
  
  @StateObject var vm: DetailViewModel
   
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        ZStack {
            Text("Hello")
        }
        .navigationTitle("DetailView")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
        .navigationTitle("DetailView")

}
