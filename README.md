# Task Manager 📝

<p align="center">
  <img src="assets/images/logo.svg" width="120" alt="Task Manager Logo" />
</p>

<p align="center">
  <strong>A modern, production-ready Task Management application built with Flutter following Feature-First Clean Architecture.</strong>
</p>

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.38.1-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter Version" /></a>
  <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-3.10.0-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart Version" /></a>
  <a href="https://github.com/atikur01/task_manager_app/actions/workflows/main.yml"><img src="https://img.shields.io/badge/Build%20%26%20Release-Passing-success?style=for-the-badge&logo=githubactions&logoColor=white" alt="Build Status" /></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge" alt="License" /></a>
  <a href="https://github.com/atikur01/task_manager_app/pulls"><img src="https://img.shields.io/badge/PRs-Welcome-brightgreen.svg?style=for-the-badge" alt="PRs Welcome" /></a>
</p>

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Application Screenshots](#-application-screenshots)
- [Architecture & Design Pattern](#-architecture--design-pattern)
- [Technology Stack](#-technology-stack)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the Application](#running-the-application)
- [Project Directory Structure](#-project-directory-structure)
- [CI/CD & Release Pipeline](#-cicd--release-pipeline)
- [Contributing](#-contributing)
- [License](#-license)

---

## 📖 Overview

**Task Manager** is a feature-rich, responsive mobile application built with **Flutter** designed to enhance personal productivity and workflow tracking. It features a complete user authentication cycle, task categorization (New, In Progress, Completed, Cancelled), profile management with custom avatar updates, and persistent state management powered by `Provider` and `shared_preferences`.

Built with scalable, maintainable **Feature-First Clean Architecture**, the project decouples presentation logic from data layers, ensuring testability and modularity across features.

---

## ✨ Key Features

- 🔐 **Secure Authentication**: User sign up, login, password recovery, and OTP verification using pin-code fields.
- 📋 **Comprehensive Task Lifecycle**:
  - Create new tasks with detailed titles and descriptions.
  - Track real-time status chips (*New*, *Progress*, *Completed*, *Cancelled*).
  - Update task progress or delete tasks with immediate state updates.
- 👤 **Profile & Identity Management**: View and update user credentials and change profile pictures via device camera/gallery.
- 🔄 **Reactive State Management**: Global state management leveraging `MultiProvider` for seamless data reactivity across screens.
- 💾 **Session Persistence**: Persistent auth tokens and user preferences using `shared_preferences`.
- 📱 **Adaptive & Modern UI**: Tailored layouts with visual consistency across varying screen dimensions.

---

## 📸 Application Screenshots

<div align="center">

### Authentication & Onboarding
| Splash Screen | Login Screen | Sign Up Screen |
| :---: | :---: | :---: |
| <img src="screenshorts/splash_screen.jpeg" width="230" alt="Splash Screen" /> | <img src="screenshorts/login_page.jpg" width="230" alt="Login Page" /> | <img src="screenshorts/sign_up_page.jpg" width="230" alt="Sign Up Page" /> |

<br />

### Dashboard & Profile Management
| Task Dashboard | User Profile |
| :---: | :---: |
| <img src="screenshorts/home_page.jpg" width="230" alt="Home Page" /> | <img src="screenshorts/profile_page.jpg" width="230" alt="Profile Page" /> |

</div>

---

## 🏗️ Architecture & Design Pattern

The application enforces a **Feature-First Clean Architecture** approach. Code is partitioned into domain features (`auth`, `task`, `profile`), separating the **Data** layer from the **Presentation** layer for high maintainability.

```
lib/
├── app/                  # Application configuration & root routes
│   └── app.dart
├── core/                 # Shared core utilities & cross-cutting concerns
│   ├── constants/        # App assets, colors, and static values
│   ├── models/           # Shared models & response wrappers
│   ├── network/          # HTTP network caller & API endpoints
│   └── widgets/          # Reusable shared UI widgets
├── features/             # Feature-based modular structure
│   ├── auth/             # Authentication feature module
│   │   ├── data/         # Auth API services & data sources
│   │   └── presentation/ # Auth screens, widgets & state providers
│   ├── profile/          # Profile management feature module
│   │   └── presentation/ # Profile screens & state providers
│   └── task/             # Task management feature module
│       ├── data/         # Task API models & data sources
│       └── presentation/ # Task lists, status screens & state providers
└── main.dart             # Application entry point with MultiProvider configuration
```

---

## 🛠️ Technology Stack

| Category | Technology / Library | Purpose |
| :--- | :--- | :--- |
| **Framework** | [Flutter 3.38+](https://flutter.dev) | Cross-platform UI toolkit |
| **Language** | [Dart 3.10+](https://dart.dev) | Strongly typed client-optimized language |
| **State Management** | [provider](https://pub.dev/packages/provider) | Reactive state management & dependency injection |
| **Networking** | [http](https://pub.dev/packages/http) | REST API communication |
| **Local Storage** | [shared_preferences](https://pub.dev/packages/shared_preferences) | Auth token & session persistence |
| **Authentication UI** | [pin_code_fields](https://pub.dev/packages/pin_code_fields) | OTP code input fields |
| **Media Handling** | [image_picker](https://pub.dev/packages/image_picker), [image](https://pub.dev/packages/image) | Profile avatar selection and compression |
| **Vector Graphics** | [flutter_svg](https://pub.dev/packages/flutter_svg) | SVG logo & icon rendering |
| **Logging** | [logger](https://pub.dev/packages/logger) | Standardized console debug logging |

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following tools installed locally:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.38.1`)
- [Dart SDK](https://dart.dev/get-dart) (`>= 3.10.0 < 4.0.0`)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter & Dart plugins installed.
- Java Development Kit (JDK) 17 or higher for Android builds.

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/atikur01/task_manager_app.git
   cd task_manager_app
   ```

2. **Fetch Dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Environment Setup**
   ```bash
   flutter doctor
   ```

### Running the Application

Launch the app on an connected emulator or physical device:

```bash
flutter run
```

To run in release mode:
```bash
flutter run --release
```

---

## 🤖 CI/CD & Release Pipeline

This repository leverages **GitHub Actions** for continuous integration and automated APK packaging upon every push to the `main` branch.

- **Workflow File**: [`.github/workflows/main.yml`](.github/workflows/main.yml)
- **Automated Tasks**:
  1. Set up JDK 17 & Flutter environment.
  2. Install project dependencies (`flutter pub get`).
  3. Compile release APK (`flutter build apk --release`).
  4. Automatically publish release artifacts to GitHub Releases under tag `latest`.

---

## 🤝 Contributing

Contributions are welcomed! If you would like to contribute:

1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the Branch (`git checkout -b feature/AmazingFeature`).
5. Open a Pull Request.

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for details.



