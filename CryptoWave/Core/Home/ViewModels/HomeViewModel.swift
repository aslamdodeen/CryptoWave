//
//  HomeViewModel.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 16/12/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
   @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value", percentageChange: 1),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value", percentageChange: -7)
    ]
    
    @Published var allCoins:[Coin] = []
    @Published var portfolioCoins:[Coin] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService = CoinDataService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
     // update allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map (filterCoins)
            .sink {[weak self] returendCoins in
                self?.allCoins = returendCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
}
