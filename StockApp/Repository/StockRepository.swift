//
//  StockRepository.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//

import Foundation

class StockRepository: StockRepositoryProtocol, Retryable {
    func retry<T>(attempts: Int, delay: TimeInterval, operation: () async throws -> T) async throws -> T {
        var lastError: Error?

                for _ in 0..<attempts {
                    do {
                        return try await operation()
                    } catch {
                        lastError = error
                        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                    }
                }
                throw lastError!
            }

    let symbols = ["AAPL", "GOOG", "TSLA", "MSFT", "AMZN", "META", "NFLX", "NVDA", "SPY", "AMD"]
    private let stockService: StockServiceProtocol
    private let cache: StockCacheProtocol

    init(stockService: StockService = StockService(), cache: StockCache = StockCache()) {
        self.stockService = stockService
        self.cache = cache
    }

    func getStocks() async throws -> [Stock] {
            do {
                if let cachedStocks = try await cache.getStocks() {
                    return cachedStocks
                }

                let stocks = try await fetchFromService()
                try await cache.saveStocks(stocks)
                return stocks
            } catch {
                print("Repository error: \(error)")
                throw error
            }
        }

        func saveStocks(_ stocks: [Stock]) async throws {
            try await cache.saveStocks(stocks)
        }

        func clearCache() async throws {
            try await cache.clearStocks()
        }

    private func processBatch(symbols: [String], batchSize: Int = 5) async throws -> [Stock] {
           var stocks: [Stock] = []

           for batch in stride(from: 0, to: symbols.count, by: batchSize) {
               let endIndex = min(batch + batchSize, symbols.count)
               let batchSymbols = Array(symbols[batch..<endIndex])

               try await withThrowingTaskGroup(of: Stock.self) { group in
                   for symbol in batchSymbols {
                       group.addTask {
                           try await self.fetchStock(for: symbol)
                       }
                   }

                   for try await stock in group {
                       stocks.append(stock)
                   }
               }
           }

           return stocks
       }

       private func fetchStock(for symbol: String) async throws -> Stock {
           return try await retry(attempts: 3, delay: 1.0) {
               async let quoteResult = stockService.fetchQuote(for: symbol)
               async let profileResult = stockService.fetchCompanyProfile(for: symbol)

               let (quote, profile) = try await (quoteResult, profileResult)

               switch (quote, profile) {
               case (.success(let quoteData), .success(let profileData)):
                   return Stock(
                       symbol: symbol,
                       companyName: profileData.name,
                       currentPrice: quoteData.currentPrice,
                       priceChange: quoteData.percentChange,
                       marketCap: profileData.marketCap,
                       high52Week: quoteData.high,
                       low52Week: quoteData.low,
                       volume: Int(profileData.shareOutstanding ?? 0),
                       peRatio: quoteData.currentPrice / (quoteData.previousClose == 0 ? 1 : quoteData.previousClose)
                   )
               case (.failure(let quoteError), _):
                   throw quoteError
               case (_, .failure(let profileError)):
                   throw profileError
               }
           }
       }

    private func fetchFromService() async throws -> [Stock] {
        return try await processBatch(symbols: symbols, batchSize: 5)
    }

    func refresh() async throws -> [Stock] {
        // Clear existing cache
        try await clearCache()

        // Fetch fresh data from service
        let stocks = try await fetchFromService()

        // Save new data to cache
        try await cache.saveStocks(stocks)

        return stocks
    }
}
