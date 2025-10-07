# MyAppName

A modern SwiftUI iOS app built with MVVM architecture, async/await, and dependency injection.

## 🏗️ Architecture

This project follows the **MVVM (Model-View-ViewModel)** pattern with the following structure:

```
Sources/
├── App/                    # App entry point and main views
│   ├── MyAppNameApp.swift
│   └── ContentView.swift
├── Features/               # Feature-based modules
│   ├── Base/              # Base classes and protocols
│   ├── Home/              # Home feature
│   └── Auth/              # Authentication feature
└── Services/              # Business logic and data services
    ├── DependencyContainer.swift
    ├── UserService.swift
    ├── DataService.swift
    └── NetworkService.swift
```

## 🚀 Features

- **MVVM Architecture**: Clean separation of concerns with ViewModels managing state
- **Dependency Injection**: Centralized dependency management with `DependencyContainer`
- **Async/Await**: Modern Swift concurrency for network requests and data operations
- **SwiftUI**: Declarative UI with iOS 17+ features
- **Testing**: Comprehensive test coverage for ViewModels and Services

## 🛠️ Tech Stack

- **SwiftUI** - Declarative UI framework
- **Combine** - Reactive programming (via `@Published` properties)
- **Async/Await** - Modern Swift concurrency
- **Dependency Injection** - Custom container for service management
- **UserDefaults** - Local data persistence
- **URLSession** - Network requests

## 📱 Key Components

### Base Architecture
- `BaseViewModel` - Protocol and base class for all ViewModels
- `DependencyContainer` - Centralized dependency injection
- `ViewModel<State, Action>` - Generic ViewModel with loading states and error handling

### Services
- `UserService` - User authentication and profile management
- `DataService` - Local data persistence with UserDefaults
- `NetworkService` - HTTP requests with async/await

### Features
- **Home Feature**: Item listing with search, filtering, and pull-to-refresh
- **Auth Feature**: Login/logout with form validation

## 🧪 Testing

The project includes comprehensive tests for:
- ViewModels with async operations
- Services with dependency injection
- Dependency container functionality

Run tests with:
```bash
swift test
```

## 🚀 Getting Started

1. **Open in Xcode**: Open the project in Xcode on macOS
2. **Build**: The project uses Swift Package Manager
3. **Run**: Select iOS simulator and run the app

### Demo Credentials
- Email: `test@example.com`
- Password: `password`

## 📦 Dependencies

This project uses Swift Package Manager with no external dependencies, keeping it lightweight and focused on core SwiftUI and iOS features.

## 🎯 Best Practices

- **State Management**: All state is managed through ViewModels with `@Published` properties
- **Error Handling**: Centralized error handling with user-friendly messages
- **Loading States**: Consistent loading indicators across the app
- **Dependency Injection**: All dependencies are injected through the container
- **Async Operations**: All network and heavy operations use async/await
- **Testing**: Comprehensive test coverage for business logic

## 🔄 Data Flow

1. **View** triggers an action
2. **ViewModel** handles the action and updates state
3. **Service** performs business logic or data operations
4. **View** automatically updates based on state changes

This creates a unidirectional data flow that's easy to test and maintain.
