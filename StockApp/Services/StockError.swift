//
//  StockError.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//

import Foundation

enum StockError: LocalizedError {
    case networkError(Error)
    case cacheError(Error)
    case invalidData
    case rateLimitExceeded
    case badServerResponse

    var errorDescription: String? {
        switch self {
        case .networkError(let error): return "Network error: \(error.localizedDescription)"
        case .cacheError(let error): return "Cache error: \(error.localizedDescription)"
        case .invalidData: return "Invalid data received"
        case .rateLimitExceeded: return "API rate limit exceeded"
        case .badServerResponse: return "Bad server response"
        }
    }
}
