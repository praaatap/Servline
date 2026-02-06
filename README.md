# Servline 📱

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-%232D3748.svg?style=for-the-badge&logo=riverpod&logoColor=white)
![GoRouter](https://img.shields.io/badge/GoRouter-blue.svg?style=for-the-badge)

**Servline** is a modern mobile application designed to eliminate physical waiting lines. It allows users to join a virtual queue, relax, and get notified when it's their turn.

## ✨ Features

- **🚀 Smart Onboarding**: Seamless introduction to the app's benefits.
- **📍 Nearby Locations**: Automatically find waiting rooms near you using location services.
- **🎟️ Virtual Token**: Get a digital ticket and track your position in real-time.
- **🔔 Gentle Alerts**: Receive notifications when your turn is approaching.
- **🔐 Secure Authentication**: Easy login and "Continue as Guest" options.
- **🎨 Modern UI**: Clean, accessible, and beautiful interface built with Material 3.

## 📸 Screenshots

| Onboarding 1 | Onboarding 2 | Login |
|:---:|:---:|:---:|
| ![Intro](https://via.placeholder.com/200x400?text=Intro) | ![How It Works](https://via.placeholder.com/200x400?text=How+It+Works) | ![Login](https://via.placeholder.com/200x400?text=Login) |

| Home Screen | Notification Access | Location Access |
|:---:|:---:|:---:|
| ![Home](https://via.placeholder.com/200x400?text=Home) | ![Notif](https://via.placeholder.com/200x400?text=Notification) | ![Location](https://via.placeholder.com/200x400?text=Location) |

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: [Riverpod 2.0 (Notifier)](https://riverpod.dev/)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Networking**: (Planned: Dio/Http)
- **Typography**: Google Fonts (Poppins, Inter)

## 📂 Project Structure

```
lib/
├── models/         # Data models (User, Ticket, Location)
├── providers/      # Riverpod providers (Auth, Ticket, Location)
├── screens/        # UI Screens
│   ├── auth/       # Login, Register
│   ├── home/       # Home implementation
│   │   └── widgets/# Home-specific widgets
│   ├── onboarding/ # Onboarding flow screens
│   └── splash/     # Splash screen
├── router.dart     # GoRouter configuration
└── main.dart       # App entry point & Theme config
```

## 🚀 Getting Started

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/silent-queue.git
    ```

2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run the App**:
    ```bash
    flutter run
    ```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
