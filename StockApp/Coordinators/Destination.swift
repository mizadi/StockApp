//
//  Destination.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//

import Foundation

enum Destination: Hashable {
    case home
    case stockDetail(Stock)

    // Custom equality and hashing for `Destination`
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home):
            return true
        case (.stockDetail(let lhsStock), .stockDetail(let rhsStock)):
            return lhsStock == rhsStock // Compare `Stock` objects
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .home:
            hasher.combine(0) // Use a static value for `.home`
        case .stockDetail(let stock):
            hasher.combine(stock) // Use the whole `Stock` for `.stockDetail`
        }
    }
}
