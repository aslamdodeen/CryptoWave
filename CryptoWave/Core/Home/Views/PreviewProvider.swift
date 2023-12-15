//
//  PreviewProvider.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 15/12/2023.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var Dev:DeveloperPreview {
        return DeveloperPreview.instance
    }
    
    
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let coin = Coin(id: "bitcoin",
                    symbol: "btc",
                    name: "Bitcoin",
                    image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
                    currentPrice: 6140,
                    marketCap: 823974293874,
                    marketCapRank: 1,
                    fullyDilutedValuation: 345345,
                    totalVolume: 345454,
                    high24H: 61712,
                    low24H: 56220,
                    priceChange24H: 3952,
                    priceChangePercentage24H: 6.5454,
                    marketCapChange24H: 4256565445,
                    marketCapChangePercentage24H: 456546546,
                    circulatingSupply: 45645654,
                    totalSupply: 456456,
                    maxSupply: 456456,
                    ath: 456456,
                    athChangePercentage: 45654,
                    athDate: "2013-07-06T00:00:00.000Z",
                    atl: 67.81,
                    atlChangePercentage: 90020.24075,
                    atlDate: "2013-07-06T00:00:00.000Z",
                    lastUpdated: "2014-07-06T00:00:00.000Z",
                    sparklineIn7D: SparklineIn7D(price: [2384723742374892374,2384324,2343244]),
                    priceChangePercentage24HInCurrency: 3432.43,
                    currentHoldings: 1.5)
}
