![DawaKhana](https://github.com/user-attachments/assets/1abd83bc-804d-44bd-b6bf-ffe3509423e9)

# DawaKhana

A Flutter-based hospital management and appointment booking application.

## Overview

DawaKhana is a comprehensive mobile application designed to streamline hospital services, including appointment booking, doctor consultations, patient profiles, and real-time chat functionality. Built with Flutter, it provides a cross-platform solution for iOS, Android, Web, and Desktop.

## Features

- **Appointment Booking**: Schedule and manage appointments with healthcare professionals
- **Home Dashboard**: Quick access to hospital services and information
- **Chat System**: Real-time messaging with doctors and healthcare staff
- **User Profile**: Manage patient information and medical history
- **Doctor Directory**: Browse and view all available doctors
- **Splash Screen**: Welcoming entry point for the application

## Tech Stack

- **Framework**: Flutter SDK (>=2.18.5 <3.0.0)
- **Language**: Dart
- **UI Components**:
  - Curved Navigation Bar
  - Syncfusion Date Picker
  - Floating Bottom Bar
  - Material Design & Cupertino Icons

## Project Structure

```
DawaKhanamaster/
├── lib/
│   ├── models/          # Data models
│   ├── res/             # Resources (colors, strings, etc.)
│   ├── screens/         # UI screens
│   │   ├── Appointment.dart
│   │   ├── Chat.dart
│   │   ├── Home.dart
│   │   ├── Profile.dart
│   │   ├── SeeAll.dart
│   │   └── Splash.dart
│   ├── widgets/         # Reusable UI components
│   └── main.dart        # Application entry point
├── assets/
│   └── images/          # Image assets
├── android/             # Android platform files
├── ios/                 # iOS platform files
├── web/                 # Web platform files
├── windows/             # Windows platform files
├── linux/               # Linux platform files
├── macos/               # macOS platform files
└── pubspec.yaml         # Project dependencies
```

## Getting Started

### Prerequisites

- Flutter SDK (2.18.5 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- For iOS development: Xcode (macOS only)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/codygharte/DawaKhana.git
   cd DawaKhana/DawaKhanamaster
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Platform-Specific Setup

**Android:**
```bash
flutter run -d android
```

**iOS:**
```bash
flutter run -d ios
```

**Web:**
```bash
flutter run -d chrome
```

**Desktop:**
```bash
flutter run -d windows  # or macos/linux
```

## Dependencies

| Package | Version | Purpose |
|---------|---------|----------|
| cupertino_icons | ^1.0.2 | iOS-style icons |
| curved_navigation_bar | ^1.0.3 | Custom navigation bar |
| syncfusion_flutter_datepicker | ^20.3.60 | Date selection widget |
| flutter_floating_bottom_bar | ^1.1.0 | Floating bottom navigation |
| intl | ^0.19.0 | Internationalization and date formatting |
| flutter_lints | ^2.0.0 | Code quality checks |

## Development

### Running Tests

```bash
flutter test
```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is private and not published to pub.dev.

## Contact

For questions or support, please open an issue on the GitHub repository.
