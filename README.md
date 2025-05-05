# StockApp

A Swift-based iOS application that provides real-time stock market data using the Finnhub API, implementing MVVM+C architecture with modern Swift concurrency.

## Features

- Real-time stock quotes with auto-refresh
- Company profile information
- Offline data persistence using CoreData
- Retry mechanism for failed network requests
- Thread-safe data handling using Actors

## Architecture

### MVVM+C Pattern
- **Views**: SwiftUI views for displaying stock data
- **ViewModels**: Business logic and data transformation
- **Models**: Data models for stocks and company profiles
- **Coordinators**: Handle navigation flow and dependency injection
- **Services**: Network and persistence layers

### Data Flow
View <-> ViewModel <-> StockRepository <- StockService ↓ CoreData Store


## Technical Implementation

### Network Layer
- Async/await for network calls
- Result type for error handling
- Automatic retry mechanism for failed requests
- Background refresh using `URLSession`

### Error Handling
- Custom `StockError` enum for domain-specific errors
- Comprehensive error handling across network and persistence layers
- User-friendly error messages and recovery options

### Local Storage
- CoreData integration for offline persistence
- Migration support for schema changes
- Background context for performance optimization

### Concurrency
- Actor-based state management preventing data races
- `@MainActor` usage for UI updates
- Structured concurrency with async/await

### Best Practices
- Protocol-oriented design for testability
- Dependency injection
- Clean architecture principles
- SwiftUI previews for UI development

## Setup

1. Clone the repository
2. Open `StockApp.xcodeproj` in Xcode
3. Replace `<Your API KEY>` in `StockService.swift` with your Finnhub API key
4. Build and run the project

## API Integration

The app uses Finnhub.io API with:
- Automatic retry for failed requests
- Rate limiting handling
- Background refresh every 30 seconds
- Request caching

## Performance

- Efficient CoreData fetching with NSFetchedResultsController
- Background processing for heavy operations
- Memory management using weak references
- Network caching strategy

## Author

Created by Adi Mizrahi
