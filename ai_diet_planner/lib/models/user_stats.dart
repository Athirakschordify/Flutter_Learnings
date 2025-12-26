class UserStats {
  final int age;
  final double heightCm;
  final double weightKg;
  final String goal;
  final String dietType;

  UserStats({
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.goal,
    required this.dietType,
  });

  double get bmi {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  String get bmiStatus {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    return 'Overweight';
  }
}
