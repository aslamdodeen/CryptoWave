//
//  CoinRowView.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 15/12/2023.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin:Coin
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack(spacing:0) {
            leftColumn
            Spacer()
            if showHoldingColumn {
                centerColumn
            }
            rightColum
        }
        .font(.subheadline)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(coin:DeveloperPreview.instance.coin, showHoldingColumn: true)
}
#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(coin:DeveloperPreview.instance.coin, showHoldingColumn: true)
        .preferredColorScheme(.dark)
}


extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing:0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 32)
            
            CoinImageView(coin: coin)
                .frame(width: 30,height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
        }
    }
    
    private var centerColumn: some View {
        VStack {
            Text(coin.currentHoldingsvalue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var rightColum: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundColor(Color.theme.accent)
            Text("\(coin.priceChangePercentage24H ?? 0)%")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green :
                        Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
    }

}
