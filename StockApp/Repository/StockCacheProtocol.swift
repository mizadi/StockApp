//
//  StockCacheProtocol.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//


protocol StockCacheProtocol {
    func getStocks() async throws -> [Stock]?
    func saveStocks(_ stocks: [Stock]) async throws
    func clearStocks() async throws
}
