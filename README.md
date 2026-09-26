# Grocery Go - Smart E-Commerce Mobile App 🛒

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![BLoC](https://img.shields.io/badge/State_Management-flutter__bloc-blue?style=for-the-badge)](https://bloclibrary.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Clean Architecture](https://img.shields.io/badge/Architecture-DDD_%26_Clean_Arch-brightgreen?style=for-the-badge)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

**Grocery Go** is an enterprise-grade mobile e-commerce application built with **Flutter**, designed around **Domain-Driven Design (DDD)** and **Clean Architecture**. Featuring robust state management with **BLoC**, dependency injection via **Injectable/GetIt**, multi-flavor build setups, and multi-language support (English & Vietnamese).

---

## 🌟 Key Features

- **🛍️ Catalog & Smart Search**: Real-time product filtering, category browsing, and price discovery.
- **🛒 Cart & Order Management**: Reactive shopping cart calculations, quantity adjustment, and item caching.
- **❤️ Favorites & Watchlists**: Fast bookmarking of essential items with instant local and remote synchronization.
- **👤 Authentication & Security**: Secure token storage with `flutter_secure_storage`, refresh token flows, and role management.
- **🌍 Internationalization (i18n)**: Native bilingual support (English & Vietnamese) powered by `.arb` localization files.
- **🎯 Multi-Flavor Architecture**: Independent build environments for **Development**, **Staging**, and **Production**.

---

## 🏛 Clean Architecture & Layered Design

```
lib/
├── core/                # Core utilities, environment configs, logging & design tokens
│   ├── env/             # Flavors configuration (Dev, Staging, Prod)
│   ├── logging/         # Centralized application logging & crash diagnostics
│   └── extensions/      # BuildContext & type extensions
├── data/                # Data Layer: Data sources, models, DTOs & repositories impl
│   ├── datasources/     # Local (SecureStorage) & Remote (REST API via Dio)
│   ├── models/          # Request schemas, parameter DTOs, response mappings
│   ├── mappers/         # Clean domain entity <-> DTO mappers
│   └── repositories/    # Concrete repository implementations
├── di/                  # Dependency Injection setup (Injectable & GetIt)
├── domain/              # Domain Layer: Pure business logic & entities
│   ├── entities/        # Immutable domain models (Cart, Product, Category, User)
│   ├── repository/      # Repository interface contracts
│   └── usecase/         # Discrete business use cases (Single Responsibility)
├── l10n/                # Localization resources (English & Vietnamese .arb)
└── presentation/        # Presentation Layer: UI & Reactive State
    ├── bloc/            # Feature BLoCs (Cart, Account, Shop, ProductDetail, etc.)
    ├── routes/          # Declarative AppRouter navigation
    ├── screens/         # Feature UI views & pages
    └── theme/           # Color schemes, typography & reusable UI components
```

---

## 🛠 Tech Stack

| Component | Technology |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev/) & [Dart](https://dart.dev/) |
| **Architecture** | Clean Architecture, Domain-Driven Design (DDD) |
| **State Management** | [flutter_bloc](https://pub.dev/packages/flutter_bloc) |
| **Dependency Injection** | [get_it](https://pub.dev/packages/get_it) & [injectable](https://pub.dev/packages/injectable) |
| **Networking** | [dio](https://pub.dev/packages/dio) with custom interceptors & error mappers |
| **Storage** | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) |
| **Localization** | Flutter gen-l10n (`app_en.arb`, `app_vi.arb`) |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.0.0)
- Dart SDK
- Android SDK / Xcode

### Installation

1. **Clone the repo:**
   ```bash
   git clone https://github.com/minKasent/grocery_go.git
   cd grocery_go
   ```

2. **Install packages:**
   ```bash
   flutter pub get
   ```

3. **Run code generation (Injectable & Serialization):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Launch by Environment Flavor:**
   ```bash
   # Development
   flutter run -t lib/main_dev.dart

   # Staging
   flutter run -t lib/main_staging.dart

   # Production
   flutter run -t lib/main_prod.dart
   ```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.