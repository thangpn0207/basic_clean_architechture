
# Flutter Project Documentation: Clean Architecture & Modern Stack

## 1. Overview

This document provides an overview of the architecture, structure, and technology choices for this Flutter application. The project implements a **Clean Architecture** pattern combined with a **Feature-First** structure, aiming for a codebase that is scalable, maintainable, testable, and robust, leveraging modern Flutter libraries and practices.

## 2. Core Architecture: Clean Architecture

We adhere to Clean Architecture principles, separating concerns into distinct layers with a strict dependency flow: Presentation -> Domain <- Data.

```
+---------------------+       +----------------+       +----------------+
| Presentation Layer  | ----> |  Domain Layer  | <---- |   Data Layer   |
| (UI, State, Router, |       | (Business Logic|       | (Data Fetching,|
|  Forms, i18n)       |       |  Entities,     |       |  Storage,      |
|                     |       |  Repo Contracts)|     |  Models)       |
| Depends on Domain   |       +----------------+       +----------------+
+---------------------+               ^                        |
                                      |                        |
                                      +------------------------+
                                        (Implements Contracts)
```

*   **Presentation:** Handles UI, state management (`bloc`), navigation (`go_router` via `core/routes`), user input, and localization (`core/locale`). Interacts with the Domain layer via Use Cases.
*   **Domain:** Contains core business logic (Use Cases), business entities, and repository contracts (interfaces). Pure Dart, framework-independent. Feature-specific domain logic resides within `features/*/domain/`.
*   **Data:** Implements repository contracts. Handles data fetching/storage using network clients (`dio`), local storage (`shared_preferences`, potentially `session_cache.dart`), connectivity checks (`core/network`), and maps data models to Domain entities. Feature-specific data logic resides within `features/*/data/`.

## 3. Project Structure (`lib/`)

The project uses a **Feature-First** organization, grouping all code related to a specific feature together. Shared code resides in the `core` directory.

```
lib/
├── core/                     # Shared utilities, constants, base classes, DI modules
│   ├── di/                   # Dependency Injection Modules (using Injectable)
│   ├── error/                # Shared Failure/Exception classes
│   ├── locale/               # Localization/Internationalization setup (using Intl)
│   ├── network/              # Network utilities (e.g., Connectivity checker)
│   ├── routes/               # Routing configuration (using GoRouter)
│   ├── usecases/             # Base UseCase class or truly shared use cases
│   └── utils/                # Generic utility functions (e.g., Logger, formatters)
│
├── features/                 # Application Features
│   ├── authentication/       # Authentication Feature
│   │   ├── data/             # Data Layer (Auth DataSources, Models, Repo Impl)
│   │   ├── domain/           # Domain Layer (Auth Entities, Repo Interface, UseCases)
│   │   └── presentation/     # Presentation Layer (Auth BLoC, Pages, Widgets)
│   └── home/                 # Home Feature
│       ├── data/             # Data Layer (Home DataSources, Models, Repo Impl)
│       ├── domain/           # Domain Layer (Home Entities, Repo Interface, UseCases)
│       └── presentation/     # Presentation Layer (Home BLoC, Pages, Widgets)
│
├── app.dart                  # Main Application Widget (likely contains MaterialApp/CupertinoApp, Router setup)
├── main.dart                 # Application entry point (initializes DI, runs the app)
└── session_cache.dart        # Custom session/data caching mechanism (if not using standard libs exclusively)

```

*   **`core/`**: Holds code shared across multiple features.
*   **`features/`**: Contains self-contained feature modules (Data, Domain, Presentation).
*   **`app.dart`**: Root application widget setup.
*   **`main.dart`**: Application entry point, DI initialization.
*   **`session_cache.dart`**: Custom session caching implementation.

## 4. Development Environment

This project was developed and tested using the following Flutter environment (example):

```
[✓] Flutter (Channel stable, 3.29.2, on macOS 15.3.2 24D81 darwin-arm64, locale en-VN)
[✓] Android toolchain - develop for Android devices (Android SDK version 36.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 16.2)
[✓] Chrome - develop for the web
[!] Android Studio (not installed)
[✓] IntelliJ IDEA Ultimate Edition (version 2024.3.5)
[✓] VS Code (version 1.99.0-insider)
[✓] Connected device (3 available)
[✓] Network resources
```

Ensure you have a compatible Flutter SDK installed.

## 5. IDE Setup & Recommended Plugins

Using a well-configured IDE significantly improves the development experience.

### 5.1. Visual Studio Code (VS Code)

*   **Essential Plugins:**
    *   **Dart:** Provides Dart language support, code completion, debugging, etc. (Publisher: Dart Code)
    *   **Flutter:** Adds Flutter specific features like running/debugging apps, device selection, hot reload/restart, widget guides. (Publisher: Dart Code)
*   **Recommended Plugins for this Stack:**
    *   **Bloc:** Provides snippets and code actions for creating BLoC/Cubit components, wrapping widgets with providers, etc. (Publisher: Felix Angelov)
    *   **Awesome Flutter Snippets:** A collection of commonly used Flutter code snippets. (Publisher: Nash)
    *   **Error Lens:** Highlights errors and warnings inline, making them easier to spot. (Publisher: Alexander)
    *   **Material Icon Theme:** Adds Material Design icons to your file explorer, improving visual identification of file types. (Publisher: Philipp Kief)
    *   **Pubspec Assist:** Helps add/update dependencies in `pubspec.yaml` directly from the command palette. (Publisher: Jeroen Meijer)
    *   **TODO Highlight:** Highlights TODO, FIXME, and other annotations. (Publisher: Wayou Liu)

### 5.2. IntelliJ IDEA / Android Studio

*   **Essential Plugins:**
    *   **Flutter:** Provides comprehensive Flutter support including Dart language, debugging, running apps, inspections, refactoring, UI guides, etc. (Usually bundled or easily installable via Preferences/Settings > Plugins)
    *   **Dart:** Core Dart language support. (Usually bundled with Flutter plugin)
*   **Recommended Plugins for this Stack:**
    *   **Bloc:** Provides code generation actions (New -> Bloc Class/Cubit Class), live templates, and integration for easier BLoC development. (Publisher: Felix Angelov)
    *   Check the marketplace for other potentially useful plugins like translation helpers if needed. IntelliJ's built-in features often cover what separate VS Code extensions do.

## 6. Libraries & Justification

(This section remains the same as the previous version, detailing `bloc`, `go_router`, `injectable`, `freezed`, `dio`, etc., and why they were chosen.)

| Category             | Library(s)                                                                                             | Justification                                                                                                                                                                                                                                                                                                                                                                                    |
| :------------------- | :----------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **State Management** | `bloc`, `flutter_bloc`                                                                                 | Enforces predictable state changes (Events -> BLoC -> States). Separates UI/logic. Testable, scalable. Fits Clean Arch. Likely used in `features/*/presentation/bloc/`.                                                                                                                                                                                                                    |
| **Routing**          | `go_router`                                                                                            | Declarative, state-based routing. Handles deep linking, simplifies navigation. Configured in `core/routes/` and used by `app.dart`.                                                                                                                                                                                                                                                            |
| **Dependency Injection** | `get_it`, `injectable`, `injectable_generator`                                                         | `injectable` generates `get_it` registrations, reducing boilerplate. Decouples layers, enabling easy mocking/testing. Configured in `injection.dart` (implied), modules in `core/di/`.                                                                                                                                                                                                           |
| **Immutable Data**   | `freezed`, `freezed_annotation`, `json_annotation`, `json_serializable`                                | `freezed` generates immutable classes/unions (Entities, Models, States, Events) reducing boilerplate. `json_...` handles JSON serialization for Models in `features/*/data/models/`.                                                                                                                                                                                                      |
| **Networking**       | `dio`, `pretty_dio_logger`, `connectivity_plus`                                                        | `dio`: Powerful HTTP client with interceptors. `pretty_dio_logger`: Readable network logs. `connectivity_plus`: Checks network status (`core/network/`). Used in `features/*/data/datasources/`.                                                                                                                                                                                             |
| **Local Storage**    | `shared_preferences`, (`session_cache.dart`)                                                           | `shared_preferences`: Simple key-value storage (prefs, tokens). `session_cache.dart`: Likely a custom cache logic potentially built on top or alongside SharedPreferences. Used in `features/*/data/datasources/`.                                                                                                                                                                            |
| **Functional**       | `dartz`                                                                                                | Provides `Either` for functional error handling in Repositories and Use Cases (`features/*/domain/` & `features/*/data/repositories/`).                                                                                                                                                                                                                                                      |
| **UI & Responsiveness** | `flutter_screenutil`, `flutter_svg`, `cupertino_icons`                                                 | `flutter_screenutil`: Adapts UI to screen sizes. `flutter_svg`: Renders SVGs. `cupertino_icons`: iOS icons. Used in `features/*/presentation/`.                                                                                                                                                                                                                                            |
| **Forms**            | `flutter_form_builder`, `form_builder_validators`                                                      | Simplifies form creation, state management, and validation. Likely used in `features/*/presentation/pages` or `features/*/presentation/widgets`.                                                                                                                                                                                                                                           |
| **Internationalization** | `intl`, `intl_utils`                                                                                   | `intl`: Core i18n. `intl_utils`: Generates type-safe localization accessors from `.arb` files. Setup likely in `core/locale/`.                                                                                                                                                                                                                                                              |
| **Utilities**        | `logger`, `uuid`, `equatable`                                                                          | `logger`: Flexible logging (`core/utils/`). `uuid`: Unique ID generation. `equatable`: Value equality (used if not fully replaced by `freezed`).                                                                                                                                                                                                                                            |
| **Development**      | `build_runner`, `flutter_lints`, `flutter_test`, `freezed`, `injectable_generator`, `json_serializable` | `build_runner`: Runs code generators. `flutter_lints`: Enforces code style. `flutter_test`: Testing framework. Generators automate boilerplate for `freezed`, `injectable`, `json_serializable`.                                                                                                                                                                                           |

## 7. Code Generation

This project utilizes code generation extensively (`freezed`, `injectable`, `json_serializable`, `intl_utils`). **It is crucial** to run the build runner command after making changes to annotated files or localization files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

*Tip:* You can also run `flutter pub run build_runner watch --delete-conflicting-outputs` to have it automatically regenerate files when you save changes.

## 8. Getting Started

1.  **Install Flutter:** Ensure you have the Flutter SDK installed ([Flutter installation guide](https://docs.flutter.dev/get-started/install)).
2.  **Install IDE & Plugins:** Set up VS Code or IntelliJ/Android Studio with the recommended plugins (See Section 5).
3.  **Clone:** `git clone https://github.com/thangpn0207/basic_clean_architechture.git` and `cd <project-directory>`
4.  **Install Dependencies:** `flutter pub get`
5.  **Configure Environment:** Set API keys, base URLs (check `core/di/` modules), etc., if required.
6.  **Run Code Generation:** (See Section 7)
7.  **Run the App:** Select a device/emulator and run `flutter run` or use the IDE's run button.

---