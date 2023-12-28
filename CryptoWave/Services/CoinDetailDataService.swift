//
//  CoinDetailDataService.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 23/12/2023.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    var coinDetailSubscription: AnyCancellable?
    let coin:Coin
    
    init(coin:Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
       func getCoinDetails() {
           guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
            return
        }
        
           coinDetailSubscription =  NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handelCompletion, receiveValue: {
                [weak self] returnCoinDetails in
                self?.coinDetails = returnCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
