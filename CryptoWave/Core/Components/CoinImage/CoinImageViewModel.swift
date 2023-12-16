//
//  CoinImageViewModel.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 16/12/2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel:ObservableObject {
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    private var cancellbles = Set<AnyCancellable>()
    
    private let coin:Coin
    private var dataService:CoinImageService
    
    init(coin:Coin) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubscriber()
        self.isLoading = true
    }
    
    private  func addSubscriber() {
        dataService.$image
            .sink { [weak self](_) in
                self?.isLoading = false
            } receiveValue: { returendImage in
                self.image = returendImage
            }
            .store(in: &cancellbles)
    }
}
