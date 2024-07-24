//
//  Cryptocurrency.swift
//  crypto-swift-uikit
//
//  Created by Vinicius Scorsatto on 25/07/2024.
//

import Foundation

struct Cryptocurrency: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let currentPrice: Double
    let marketCap: Double
    let marketCapRank: Int
    let totalVolume: Double
    let high24h: Double
    let low24h: Double
    let priceChangePercentage24h: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}

