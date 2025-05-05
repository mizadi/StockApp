//
//  StockCache.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//


import Foundation
import CoreData


actor StockCache: StockCacheProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
    }

    func saveStocks(_ stocks: [Stock]) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            context.performAndWait {
                do {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StockEntity")
                    let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    _ = try context.execute(batchDelete)

                    for stock in stocks {
                        let entity = NSEntityDescription.insertNewObject(forEntityName: "StockEntity", into: context) as! StockEntity
                        entity.symbol = stock.symbol
                        entity.companyName = stock.companyName
                        entity.currentPrice = stock.currentPrice
                        entity.priceChange = stock.priceChange
                        entity.marketCap = stock.marketCap ?? 0
                        entity.high52Week = stock.high52Week
                        entity.low52Week = stock.low52Week
                        entity.volume = Int64(stock.volume)
                        entity.peRatio = stock.peRatio
                    }

                    try context.save()
                    continuation.resume(returning: ())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getStocks() async throws -> [Stock]? {
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[Stock]?, Error>) in
            context.performAndWait {
                do {
                    let fetchRequest = NSFetchRequest<StockEntity>(entityName: "StockEntity")
                    let entities = try context.fetch(fetchRequest)

                    if entities.isEmpty {
                        continuation.resume(returning: nil)
                        return
                    }

                    let stocks = entities.map { entity in
                        Stock(
                            symbol: entity.symbol ?? "",
                            companyName: entity.companyName ?? "",
                            currentPrice: entity.currentPrice,
                            priceChange: entity.priceChange,
                            marketCap: entity.marketCap,
                            high52Week: entity.high52Week,
                            low52Week: entity.low52Week,
                            volume: Int(entity.volume),
                            peRatio: entity.peRatio
                        )
                    }
                    continuation.resume(returning: stocks)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func clearStocks() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            context.performAndWait {
                do {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StockEntity")
                    let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    _ = try context.execute(batchDelete)
                    try context.save()
                    continuation.resume(returning: ())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
