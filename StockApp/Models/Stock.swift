//
//  Stock.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//

import Foundation

struct Stock: Identifiable, Hashable, Codable {
    var id = UUID()
    let symbol: String
    let companyName: String
    let currentPrice: Double
    let priceChange: Double
    let marketCap: Double?
    let high52Week: Double
    let low52Week: Double
    let volume: Int
    let peRatio: Double

    // Implement Hashable manually since UUID() creates a new value each time
    func hash(into hasher: inout Hasher) {
        hasher.combine(symbol)
    }

    static func == (lhs: Stock, rhs: Stock) -> Bool {
        lhs.symbol == rhs.symbol
    }
}
