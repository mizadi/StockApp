//
//  StockServiceProtocol.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//


protocol StockServiceProtocol {
    func fetchQuote(for symbol: String) async throws -> Result<StockQuoteModel, StockError>
    func fetchCompanyProfile(for symbol: String) async throws -> Result<CompanyProfile, StockError>
}
