//
//  DetailViewModel.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 24/12/2023.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin:Coin) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print("Recived Coin deatails data")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
}
