//
//  StockRepositoryProtocol.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//


protocol StockRepositoryProtocol {
    func getStocks() async throws -> [Stock]
    func saveStocks(_ stocks: [Stock]) async throws
    func clearCache() async throws
    func refresh() async throws -> [Stock]
}
