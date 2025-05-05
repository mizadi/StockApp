//
//  HomeView.swift
//  StockApp
//
//  Created by Adi Mizrahi on 04/05/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        List {
            if viewModel.isLoading {
                LoadingView()
            } else {
                ForEach(viewModel.stocks) { stock in
                    StockRowView(stock: stock)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coordinator.navigateToStockDetail(stock)
                        }
                }
            }
        }
        .refreshable {
                    try? await viewModel.refresh()
        }
        .listStyle(.plain)
        .refreshable {
            try? await viewModel.refresh()
        }
        .alert("Error", isPresented: Binding(
            get: { viewModel.error != nil },
            set: { if !$0 { viewModel.error = nil } }
        )) {
            Button("OK") { viewModel.error = nil }
        } message: {
            Text(viewModel.error ?? "")
        }
    }
}

struct LoadingView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
            Spacer()
        }
        .padding()
    }
}

struct StockRowView: View {
    let stock: Stock

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.symbol)
                    .font(.headline)
                Text(stock.companyName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(String(format: "$%.2f", stock.currentPrice))
                    .font(.headline)
                Text(String(format: "%.2f%%", stock.priceChange))
                    .font(.subheadline)
                    .foregroundColor(stock.priceChange >= 0 ? .green : .red)
            }
        }
        .padding(.vertical, 4)
    }
}
