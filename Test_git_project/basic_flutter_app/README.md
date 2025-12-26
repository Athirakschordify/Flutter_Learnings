# Basic Flutter App

A basic Flutter application demonstrating a structured project layout.

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── screens/
│   └── home_screen.dart   # Home screen widget
├── services/
│   └── api_service.dart   # API service (placeholder)
├── utils/
│   └── constants.dart     # Application constants
└── widgets/               # Custom widgets (placeholder directory)

test/
└── widget_test.dart       # Widget tests

android/                   # Android platform code
ios/                       # iOS platform code
linux/                     # Linux platform code
macos/                     # macOS platform code
web/                       # Web platform code
windows/                   # Windows platform code
```

## Getting Started

### Prerequisites

- Flutter SDK (^3.10.4)
- Dart SDK (^3.10.4)

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

### Running Tests

Run `flutter test` to execute the test suite.

## Git Branch Setup

```bash
# Make sure you are on main
git checkout main

# Create dev branch
git checkout -b dev
git push -u origin dev

# Go back to main
git checkout main

# Create staging branch
git checkout -b staging
git push -u origin staging

# Go back to main
git checkout main

# Create prod branch
git checkout -b prod
git push -u origin prod

git branch -a
```

## Features

- Structured Flutter project layout
- Cross-platform support (Android, iOS, Web, Desktop)
- Basic home screen with placeholder content

## Contributing

Contributions are welcome. Please ensure code follows the linting rules defined in `analysis_options.yaml`.
