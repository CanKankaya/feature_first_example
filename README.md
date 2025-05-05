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

This Flutter application demonstrates a **Feature-First Architecture** pattern using the GetX state management library. The app consumes the JSONPlaceholder API to showcase posts, comments, and users in a well-structured, maintainable codebase.

## Features

- View, create, update, and delete posts
- View post details and associated comments
- Browse user profiles and their posts
- Clean, maintainable architecture

## Architecture Overview

This project is organized using a **Feature-First Architecture** approach, which organizes code based on features rather than technical layers. This approach offers several advantages:

- **Domain Isolation**: Each feature is isolated, making the codebase more maintainable
- **Scalability**: Easy to add new features without affecting existing ones
- **Testability**: Feature modules can be tested independently
- **Clear Boundaries**: Each feature has well-defined responsibilities

### Technology Stack

- **Flutter**: UI framework
- **GetX**: State management, dependency injection, and navigation
- **HTTP**: API communication
- **JSONPlaceholder API**: RESTful API providing fake data

## Project Structure

```
lib/
│
├── main.dart                 # Application entry point
│
├── common/                   # Shared components across features
│   ├── models/               # Data models used across features
│   │   ├── post.dart
│   │   ├── comment.dart
│   │   └── user.dart
│   ├── constants/            # Application-wide constants
│   └── widgets/              # Shared widgets
│
├── core/                     # Core functionality and services
│   ├── app/                  # App configuration
│   │   ├── bindings.dart     # GetX dependency injection setup
│   │   └── routes.dart       # Application routes
│   ├── services/             # Core services
│   │   └── api_service.dart  # Generic API handling service
│   └── utils/                # Utility classes and functions
│
└── features/                 # Feature modules
    ├── posts/                # Posts feature
    │   ├── data/             # Data layer
    │   │   ├── post_repository.dart
    │   │   └── comment_repository.dart
    │   └── presentation/     # UI layer
    │       ├── controllers/  # GetX controllers for state management
    │       │   ├── posts_controller.dart
    │       │   └── post_detail_controller.dart
    │       └── screens/      # UI screens for this feature
    │           ├── posts_screen.dart
    │           └── post_detail_screen.dart
    │
    └── users/                # Users feature
        ├── data/             # Data layer
        │   └── user_repository.dart
        └── presentation/     # UI layer
            ├── controllers/  # GetX controllers for state management
            │   └── users_controller.dart
            └── screens/      # UI screens for this feature
                ├── users_screen.dart
                └── user_posts_screen.dart
```

## Architecture Layers Explained

### 1. Core Layer
Contains application-wide functionality:
- **API Service**: Generic service handling HTTP requests to JSONPlaceholder API
- **App Bindings**: Setup for GetX dependency injection
- **Routes**: Application navigation routes

### 2. Common Layer 
Shared resources used across features:
- **Models**: Data models representing API entities (Post, Comment, User)
- **Widgets**: Reusable UI components

### 3. Feature Modules
Each feature is a self-contained module with its own layers:
- **Data Layer**: Repositories for API communication, specific to the feature
- **Presentation Layer**: UI components and state management
  - **Controllers**: GetX controllers for reactive state management
  - **Screens**: UI screens for the feature

## Implementation Details

### GetX for State Management
- **Reactive State**: Using Rx variables and Obx for reactive UI updates
- **Dependency Injection**: Automatic dependency resolution with Get.find()
- **Navigation**: Route management with GetX navigation

### API Service
The application uses a centralized API service that handles all HTTP communication with the JSONPlaceholder API, providing a clean interface for repositories to interact with.

### Feature Independence
Each feature (posts, users) is independent and can be developed, tested, and maintained separately, while still sharing common resources when needed.

## Getting Started

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Learning Resources

- [GetX](https://pub.dev/packages/get)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)
- [Feature-First Architecture in Flutter](https://codewithandrea.com/articles/flutter-project-structure/)