//
//  HomeViewModel.swift
//  StockApp
//
//  Created by Adi Mizrahi on 04/05/2025.
//


// Features/Home/ViewModels/HomeViewModel.swift

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var isLoading: Bool = false
    @Published var error: String?

    private var cancellables = Set<AnyCancellable>()

    private let repository: StockRepositoryProtocol

    init(repository: StockRepositoryProtocol = StockRepository()) {
        self.repository = repository
        Task {
            await fetchRandomStocks()
        }
        setupTimer()
    }

    func fetchRandomStocks() async {
        guard stocks.isEmpty else { return }

        isLoading = true
        error = nil

        do {
            let newStocks = try await repository.getStocks()
            stocks = newStocks
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }

    func refresh() async throws {
        func refresh() async throws {
                stocks = try await repository.refresh()
        }
    }

    private func setupTimer() {
            Timer.publish(every: 30, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    Task {
                        try? await self?.refresh()
                    }
                }
                .store(in: &cancellables)
        }
}
