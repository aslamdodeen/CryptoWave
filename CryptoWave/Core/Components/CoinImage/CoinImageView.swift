//
//  CoinImageView.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 16/12/2023.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm:CoinImageViewModel
    
    init(coin:Coin) {
       _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

#Preview(traits:.sizeThatFitsLayout) {
    CoinImageView(coin: DeveloperPreview.instance.coin)
        .padding()
}

struct CoinImage_Previews:PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: Dev.coin, showHoldingColumn: true)
            .padding()
    }
}
