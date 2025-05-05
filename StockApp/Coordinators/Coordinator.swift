//
//  Coordinator.swift
//  StockApp
//
//  Created by Adi Mizrahi on 05/05/2025.
//

import SwiftUI

protocol Coordinator: ObservableObject {
    associatedtype ContentView: View
    func start() -> ContentView
}
