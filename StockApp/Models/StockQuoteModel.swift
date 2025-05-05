//
//  StockQuoteModel.swift
//  StockApp
//
//  Created by Adi Mizrahi on 04/05/2025.
//


// Core/Models/StockQuoteModel.swift

import Foundation

struct StockQuoteModel: Codable {
    let currentPrice: Double
    let change: Double
    let percentChange: Double
    let high: Double
    let low: Double
    let open: Double
    let previousClose: Double

    enum CodingKeys: String, CodingKey {
        case currentPrice = "c"
        case change = "d"
        case percentChange = "dp"
        case high = "h"
        case low = "l"
        case open = "o"
        case previousClose = "pc"
    }

    // Provide default values here
    init(
        currentPrice: Double = 0.0,
        change: Double = 0.0,
        percentChange: Double = 0.0,
        high: Double = 0.0,
        low: Double = 0.0,
        open: Double = 0.0,
        previousClose: Double = 0.0
    ) {
        self.currentPrice = currentPrice
        self.change = change
        self.percentChange = percentChange
        self.high = high
        self.low = low
        self.open = open
        self.previousClose = previousClose
    }
}


struct CompanyProfile: Codable {
    let name: String
    let marketCap: Double?
    let shareOutstanding: Double?

    enum CodingKeys: String, CodingKey {
        case name
        case marketCap = "marketCapitalization"
        case shareOutstanding
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
        marketCap = try container.decodeIfPresent(Double.self, forKey: .marketCap)
        shareOutstanding = try container.decodeIfPresent(Double.self, forKey: .shareOutstanding)
    }
}
