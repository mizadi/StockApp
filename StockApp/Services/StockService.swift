//
//  StockService.swift
//  StockApp
//
//  Created by Adi Mizrahi on 04/05/2025.
//


// Core/Network/StockService.swift

import Foundation

class StockService: StockServiceProtocol {
    private let session = URLSession.shared
    private let baseURL = "https://finnhub.io/api/v1"
    private let apiKey = "<Your API KEY>"

    func fetchQuote(for symbol: String) async throws -> Result<StockQuoteModel, StockError> {
        guard let url = URL(string: "\(baseURL)/quote?symbol=\(symbol)&token=\(apiKey)") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            return .failure(StockError.badServerResponse)
        }

        let quote = try JSONDecoder().decode(StockQuoteModel.self, from: data)
        return .success(quote)
    }

    func fetchCompanyProfile(for symbol: String) async throws -> Result<CompanyProfile, StockError> {
        guard let url = URL(string: "\(baseURL)/stock/profile2?symbol=\(symbol)&token=\(apiKey)") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            return .failure(StockError.badServerResponse)
        }
        let result = try JSONDecoder().decode(CompanyProfile.self, from: data)
        return .success(result)
    }
}
