//
//  MarketDataModel.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 18/12/2023.
//

import Foundation


// JSON data:
/*
 
 https://api.coingecko.com/api/v3/global
  
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 11558,
     "upcoming_icos": 0,
     "ended_icos": 3376,
     "markets": 945,
     "total_market_cap": {
       "btc": 39087036.92210404,
       "bits": 39087036922104.04,
     },
     "total_volume": {
       "btc": 1854518.6822828401,
       "sats": 185451868228284
     },
     "market_cap_percentage": {
       "btc": 50.07697574775991,
       "avax": 0.8944028396149951
     },
     "market_cap_change_percentage_24h_usd": -1.121898448339225,
     "updated_at": 1702911214
   }
 }
 
*/


struct GlobalData:Codable{
    let data: MarketDataModel?
}

struct MarketDataModel:Codable {
    
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        
        if let item = totalVolume.first(where: { $0.key == "btc" }) {
            return "\(item.value.asPercentString())"
        }
        return ""
    }
    
    
}
