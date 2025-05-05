//
//  StockDetailsResponse.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//


struct StockDetailsResponse: Codable {
    var name: String
    var description: String
    var marketCap: Double
    var currentPrice: Double

    enum CodingKeys: String, CodingKey {
        case name = "companyName"  
        case description = "description"
        case marketCap = "marketCap"
        case currentPrice = "price"
    }
}
