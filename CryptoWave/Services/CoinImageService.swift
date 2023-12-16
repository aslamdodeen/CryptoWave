//
//  CoinImageService.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 16/12/2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image:UIImage? = nil
    private var ImageSubscription: AnyCancellable?
    private let coin:Coin
    
    init(coin:Coin) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else {return}
        
        ImageSubscription =  NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
               return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handelCompletion, receiveValue: {
                [weak self] returnImage in
                self?.image = returnImage
                self?.ImageSubscription?.cancel()
            })
    }
}
