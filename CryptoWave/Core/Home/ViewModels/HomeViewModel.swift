//
//  HomeViewModel.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 16/12/2023.
//

import Foundation
import Combine
import CoreData

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins:[Coin] = []
    @Published var portfolioCoins:[Coin] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // update allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map (filterCoins)
            .sink {[weak self] returendCoins in
                self?.allCoins = returendCoins
            }
            .store(in: &cancellables)
        
        
        // Updates Porfolio
        $allCoins
            .combineLatest(portfolioDataService.$savedEntites)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobleData)
            .sink {[weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    
    func updatePortfolio(coin:Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getmarketData()
        HapticManager.notification(type: .success)
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
    
    private  func mapAllCoinsToPortfolioCoins(allCoins:[Coin], portfolioEntities:
                                       [PortfolioEntity]) -> [Coin] {
        
        allCoins
            .compactMap { currentCoin in
                guard let entity = portfolioEntities.first(where: {$0.coinID == currentCoin.id }) else {
                    return nil
                }
                
                return currentCoin.updateHoldings(amount: entity.amount)
            }
        
    }
    
    
    private func mapGlobleData(marketDataModel: MarketDataModel?, portfolioCoins:[Coin]) -> [StatisticModel] {
        
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap,percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volume = StatisticModel(title: "24 Volume", value: data.volume)
        
        let btcDominance =  StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue =
        portfolioCoins
            .map({$0.currentHoldingsvalue})
            .reduce(0, +)
        
        let previousValue =
            portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsvalue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
    
}
