//
//  AppCoordinatorView.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeView(viewModel: homeViewModel)
                .environmentObject(coordinator)
                .navigationDestination(for: Stock.self) { stock in
                    StockDetailView(stock: stock)
                        .environmentObject(coordinator)
                }
        }
    }
}
