//
//  Retryable.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//


import Foundation

protocol Retryable {
    func retry<T>(attempts: Int, delay: TimeInterval, operation: () async throws -> T) async throws -> T
}
