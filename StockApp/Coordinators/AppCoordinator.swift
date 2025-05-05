//
//  AppCoordinator.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//

import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath() // Single source of truth for navigation state

    // Method to navigate to the stock detail
    func navigateToStockDetail(_ stock: Stock) {
        path.append(stock)
    }

    // Method to go back to previous screen
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    // Method to go back to root
    func goToRoot() {
        path = NavigationPath()
    }
}
