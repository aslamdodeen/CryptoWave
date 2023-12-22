//
//  MarketDataService.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 18/12/2023.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel?
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getmarketData()
    }
    
    func getmarketData() {
        guard let url = URL(string:"https://api.coingecko.com/api/v3/global")
        else {
            return
        }
        
        marketDataSubscription =  NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handelCompletion, receiveValue: {
                [weak self] returnGlobalData in
                self?.marketData = returnGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
