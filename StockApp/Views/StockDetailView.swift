//
//  StockDetailView.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//


import SwiftUI

struct StockDetailView: View {
    let stock: Stock
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header Section
                HStack {
                    VStack(alignment: .leading) {
                        Text(stock.symbol)
                            .font(.title)
                            .bold()
                        Text(stock.companyName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    PriceView(price: stock.currentPrice, change: stock.currentPrice)
                }
                .padding()

                // Details Section
                Group {
                    DetailRow(title: "Market Cap", value: formatCurrency(stock.marketCap ?? 0))
                    DetailRow(title: "52W High", value: formatPrice(stock.high52Week))
                    DetailRow(title: "52W Low", value: formatPrice(stock.low52Week))
                    DetailRow(title: "Volume", value: formatNumber(stock.volume))
                    DetailRow(title: "P/E Ratio", value: formatDecimal(stock.peRatio))
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
    }

    private func formatPrice(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    private func formatNumber(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value)) ?? "0"
    }

    private func formatDecimal(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
}

struct PriceView: View {
    let price: Double
    let change: Double

    var body: some View {
        VStack(alignment: .trailing) {
            Text(String(format: "$%.2f", price))
                .font(.title2)
                .bold()
            Text(String(format: "%.2f%%", change))
                .foregroundColor(change >= 0 ? .green : .red)
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .bold()
        }
    }
}
