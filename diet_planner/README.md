## AI Diet Planner – Flutter On-Device AI Demo

This is a **Flutter-based AI Diet Planner** that runs **100% on-device**.  
It collects basic health details, calculates BMI, infers a health category, and then uses a **rule-based AI engine** to generate a daily meal plan – all without any backend, external AI APIs, or image processing.

### What the app does

- **Collects user inputs**: age, height (cm), weight (kg), fitness goal, and diet type (veg / non-veg).
- **Computes BMI** and classifies the user into **Underweight / Normal / Overweight**.
- **Combines rules** based on: BMI category, goal (weight loss / gain / maintenance), age band, and diet preference.
- **Generates a daily meal plan**:
  - **Breakfast**
  - **Lunch**
  - **Snacks**
  - **Dinner**
  - **General notes & lifestyle hints**
- **Displays everything on a single screen** – BMI, health status, and the personalized plan – ideal for live demos.

### On-device AI logic (no backend)

All "AI" in this demo is implemented as **deterministic rule-based logic in Dart** (`lib/main.dart`):

- BMI is calculated as \\( \text{BMI} = \frac{\text{weight (kg)}}{\text{height (m)}^2} \\).
- Rules decide:
  - Calorie bias: low / medium / high based on **goal** and **BMI category**.
  - Protein emphasis for **underweight** or **weight gain** cases.
  - Lighter carbs for **overweight** or **weight loss** cases.
  - Age-based breakfast styles and meal softness.
- These rules are combined into a **structured meal plan map** and rendered as cards.

This makes it a great **AI logic demo** for Flutter talks or POCs: the decision-making is transparent and explainable, and it works entirely offline.

### How to run

1. Make sure you have **Flutter SDK** installed and configured.
2. From the project root:

```bash
flutter pub get
flutter run
```

3. Select a device/emulator and interact with the form.

### Files of interest

- `lib/main.dart` – Flutter UI + BMI + rule-based AI diet logic.
- `pubspec.yaml` – Flutter dependencies and meta.

You can easily extend the rules to:

- Support more goals (e.g., muscle gain, medical conditions placeholders).
- Add localization.
- Persist user profiles locally for repeated use.


