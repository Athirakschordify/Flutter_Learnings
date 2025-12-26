# FMFT Ticket App

A premium Flutter application for managing event tickets.

## Features

*   **Authentication Flow**:
    *   **Welcome Screen**: Animated intro with sparkles and smooth transitions.
    *   **Login**: Secure login with Email/Phone and OTP verification.
    *   **Create Account**: User registration with consistent UI.
    *   **EULA**: End User License Agreement with scrollable terms and acceptance.
*   **Home Screen (Pouch)**:
    *   **Ticket Listing**: View Upcoming and Past tickets.
    *   **Custom Date Widget**: Sleek, compact date display in the header.
    *   **Filtering**: Toggle between ticket categories.
    *   **Search**: Built-in search bar for tickets.
*   **Navigation**:
    *   **Bottom Navigation Bar**: Easy access to Pouch, Scan, Sell, Contact, and Profile.
*   **Profile**:
    *   User details and settings management.
    *   Logout functionality.
*   **Contact Support**:
    *   Direct calling and live chat options.
    *   Contact form for support inquiries.

## File Structure

The project follows a clean, flattened structure for better maintainability:

```
lib/
├── src/
│   ├── core/           # Constants, Themes, Utilities
│   │   └── constants/  
│   ├── models/         # Data models (e.g., Ticket)
│   ├── services/       # Data providers and services
│   ├── screens/        # All application screens (Home, Auth, etc.)
│   └── widgets/        # Reusable UI components (Buttons, Inputs, etc.)
├── main.dart           # Entry point
```

## Setup & Running

1.  **Prerequisites**: Ensure you have Flutter installed.
2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the App**:
    ```bash
    flutter run
    ```

## UI Highlights

*   **Custom Design System**: Uses a centralized `AppColors` palette.
*   **Responsive Layouts**: Screens are optimized for various device sizes.
*   **Animations**: Smooth transitions and micro-interactions (e.g., Tab switching, Welcome screen animations).
