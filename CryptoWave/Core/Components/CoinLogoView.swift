//
//  CoinLogoView.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 19/12/2023.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: Coin
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50,height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
            
            
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: DeveloperPreview.instance.coin)
}

#Preview(traits: .sizeThatFitsLayout){
    CoinLogoView(coin: DeveloperPreview.instance.coin)
        .preferredColorScheme(.dark)
}
