class MealPlan {
  final String calories;
  final String proteins;
  final String carbs;
  final String fats;
  final List<String> meals;

  MealPlan({
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
    required this.meals,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      calories: json['calories']?.toString() ?? '0 Kcal',
      proteins: json['proteins']?.toString() ?? '0g',
      carbs: json['carbs']?.toString() ?? '0g',
      fats: json['fats']?.toString() ?? '0g',
      meals: List<String>.from(json['meals'] ?? []),
    );
  }
}
