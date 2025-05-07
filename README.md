### Contact

<a href="mailto:can.kankaya@outlook.com">
  <img src="https://img.shields.io/badge/Microsoft_Outlook-0078D4?style=for-the-badge&logo=microsoft-outlook&logoColor=white" alt="Outlook" />
</a>
<a href="https://www.linkedin.com/in/can-kankaya-738518158/">
  <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" />
</a>
<a href="https://t.me/cankankaya">
  <img src="https://img.shields.io/badge/Telegram-26A5E4?style=for-the-badge&logo=telegram&logoColor=white" alt="Telegram" />
</a>

# Feature-First Architecture with GetX Example

This is a very simple app that just showcases **Feature-First Architecture**

We are using Getx, but you can use any other package for state management with similar implementation. (Riverpod, Mobx, BloC etc)

## Architecture Layers

### 1. Core
Contains app-wide structural modules:
- **API Service**: Generic service handling HTTP requests with the API, like a wrapper for the repos to use.
- **App Bindings**: Dependancy injection (Using Getx)
- **Routes**: App navigation routes

### 2. Common 
Shared resources used across features:
- **Models**: Data models used commonly in the app.
- **Widgets**: Shared UI components

### 3. Features
Each feature is a self-contained module with its own layers:
- **Data**: Repositories for API requests, or other data specific modules, but specific to the feature
- **Presentation**: UI, widgets and state management.
  - **Controllers**: GetX controllers for reactive state management.
  - **Screens**: UI screens for the feature.
  - **Widgets**: Widgets used in the screen.


## Project Structure

```
lib/
│
├── main.dart                           # Application entry point
│
├── common/                             # Shared components across features
│   ├── models/                         # Data models used across features
│   │   ├── post.dart
│   │   ├── comment.dart
│   │   └── user.dart
│   ├── constants/                      # Application-wide constants
│   └── widgets/                        # Shared widgets
│
├── core/                               # Core functionality and services
│   ├── app/                            # App configuration
│   │   ├── bindings.dart               # GetX dependency injection setup
│   │   └── routes.dart                 # Application routes
│   ├── services/                       # Core services
│   │   └── api_service.dart            # Generic API handling service
│   └── utils/                          # Utility classes and functions
│
└── features/                           # Feature modules
    ├── posts/                          # Posts feature
    │   ├── data/                       # Data layer
    │   │   ├── post_repository.dart
    │   │   └── comment_repository.dart
    │   └── presentation/               # UI layer
    │       ├── controllers/            # GetX controllers for state management
    │       │   ├── posts_controller.dart
    │       │   └── post_detail_controller.dart
    │       └── screens/                # UI screens for this feature
    │           ├── posts_screen.dart
    │           └── post_detail_screen.dart
    │
    └── users/                          # Users feature
        ├── data/                       # Data layer
        │   └── user_repository.dart
        └── presentation/               # UI layer
            ├── controllers/            # GetX controllers for state management
            │   └── users_controller.dart
            └── screens/                # UI screens for this feature
                ├── users_screen.dart
                └── user_posts_screen.dart
```

## Resources

- [GetX](https://pub.dev/packages/get)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)
- [Feature-First Architecture in Flutter](https://codewithandrea.com/articles/flutter-project-structure/)