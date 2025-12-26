---
description: Steps to run the FMFT Flutter application on an iOS simulator or Chrome.
---

### Option 1: Run on Chrome (Recommended for quick testing)
If you just want to see the UI immediately, running on Chrome is the fastest way:
```bash
flutter run -d chrome
```

### Option 2: Run on iOS Simulator
1. **Launch the simulator**:
   ```bash
   open -a Simulator
   ```
   *Note: If the simulator is already open but not detected, try closing and reopening it.*

2. **Wait for it to boot**: Ensure the home screen is visible on the simulator.

3. **Check if Flutter sees it**:
   ```bash
   flutter devices
   ```
   You should see a device like `iPhone ... (mobile) • <DEVICE_ID> • ios • ...`.

4. **Run the app using the ID**:
   ```bash
   flutter run -d <DEVICE_ID>
   ```
   *Example: flutter run -d 1F0CD083-336B-4E06-8C3F-87B3B54FDC4A*

### Troubleshooting
If the app still doesn't run:
- **Clean and Refetch**:
  ```bash
  flutter clean
  flutter pub get
  ```
- **Check Environment**:
  ```bash
  flutter doctor
  ```
  Ensure there are no issues listed under "Xcode - develop for iOS and macOS".
