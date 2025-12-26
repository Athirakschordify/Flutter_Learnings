import 'package:flutter/material.dart';

void main() {
  runApp(const AiDietPlannerApp());
}

class AiDietPlannerApp extends StatelessWidget {
  const AiDietPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Diet Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const DietPlannerPage(),
    );
  }
}

class DietPlannerPage extends StatefulWidget {
  const DietPlannerPage({super.key});

  @override
  State<DietPlannerPage> createState() => _DietPlannerPageState();
}

class _DietPlannerPageState extends State<DietPlannerPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController(); // in cm
  final TextEditingController _weightController = TextEditingController(); // in kg

  String _goal = 'Weight Loss';
  String _dietType = 'Veg';

  double? _bmi;
  String? _healthStatus;
  Map<String, List<String>>? _mealPlan;

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculatePlan() {
    if (!_formKey.currentState!.validate()) return;

    final age = int.parse(_ageController.text.trim());
    final heightCm = double.parse(_heightController.text.trim());
    final weightKg = double.parse(_weightController.text.trim());

    final bmi = _calculateBmi(heightCm: heightCm, weightKg: weightKg);
    final healthStatus = _bmiCategory(bmi);
    final mealPlan = _generateMealPlan(
      age: age,
      bmi: bmi,
      healthStatus: healthStatus,
      goal: _goal,
      dietType: _dietType,
    );

    setState(() {
      _bmi = bmi;
      _healthStatus = healthStatus;
      _mealPlan = mealPlan;
    });
  }

  double _calculateBmi({required double heightCm, required double weightKg}) {
    final heightM = heightCm / 100.0;
    return weightKg / (heightM * heightM);
  }

  String _bmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    return 'Overweight';
  }

  Map<String, List<String>> _generateMealPlan({
    required int age,
    required double bmi,
    required String healthStatus,
    required String goal,
    required String dietType,
  }) {
    // This is a simple rule-based "AI" engine implemented fully on device.
    // It combines BMI category, goal, age band, and diet preference.

    final isVeg = dietType == 'Veg';
    final isYoung = age < 30;
    final isMiddleAged = age >= 30 && age < 50;

    // Calorie style rules
    String calorieBias;
    if (goal == 'Weight Loss') {
      calorieBias = 'low';
    } else if (goal == 'Weight Gain') {
      calorieBias = 'high';
    } else {
      calorieBias = 'medium';
    }

    // Protein rule adjustment based on BMI and goal
    bool extraProtein = (goal == 'Weight Gain') || healthStatus == 'Underweight';
    bool lighterCarbs = (goal == 'Weight Loss') || healthStatus == 'Overweight';

    String carbSource() {
      if (lighterCarbs) {
        return isVeg ? 'millets / brown rice / oats' : 'millets / quinoa';
      }
      return isVeg ? 'rice / chapati' : 'rice / chapati';
    }

    String proteinSource() {
      if (isVeg) {
        return extraProtein ? 'paneer, tofu, lentils, sprouts' : 'lentils, curd, paneer';
      } else {
        return extraProtein ? 'chicken breast / fish / egg whites' : 'eggs / lean chicken / fish';
      }
    }

    String healthyFatSource() {
      return isVeg ? 'nuts, seeds, olive oil' : 'nuts, seeds, olive oil, ghee (moderate)';
    }

    String snackStyle() {
      if (calorieBias == 'low') return 'fruit bowl, cucumber sticks, green tea';
      if (calorieBias == 'high') return 'fruit + handful of nuts, peanut butter toast';
      return 'fruit + nuts or buttermilk';
    }

    String breakfastBase() {
      if (isYoung) {
        return isVeg ? 'oats / vegetable upma / poha' : 'omelette with veggies + toast';
      } else if (isMiddleAged) {
        return isVeg ? 'oats with fruits / idli with sambar' : '2 eggs + veggies + 1-2 chapatis';
      } else {
        return isVeg ? 'soft idli / vegetable dalia' : 'soft boiled eggs + vegetable stew';
      }
    }

    String dinnerLightness() {
      if (calorieBias == 'low') return 'very light and early dinner';
      if (calorieBias == 'high') return 'balanced but slightly higher in calories';
      return 'light to medium dinner';
    }

    return {
      'Breakfast': [
        breakfastBase(),
        'Add protein: $proteinSource()',
        'Add healthy fats: $healthyFatSource()',
      ],
      'Lunch': [
        '1 plate salad (cucumber, tomato, carrot) before main meal',
        'Carbs: $carbSource() (controlled portion for $calorieBias calories)',
        'Protein: $proteinSource()',
        'Fats: $healthyFatSource()',
      ],
      'Snacks': [
        snackStyle(),
      ],
      'Dinner': [
        dinnerLightness(),
        'Carbs: small portion of ${carbSource()}',
        'Protein focused: $proteinSource()',
        'Herbal / green tea post dinner (no sugar)',
      ],
      'Notes': [
        'Water: 2–3L per day unless restricted by doctor.',
        'Daily light activity: 30–45 minutes walk or equivalent.',
        'This plan is a generic AI rule-based suggestion and not a medical prescription.',
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Diet Planner'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'On-device AI Diet Planner',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill in your details and let the app compute your BMI, health status, and a personalized daily meal plan using rule-based AI.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _ageController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Age',
                                        suffixText: 'years',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'Enter age';
                                        }
                                        final age = int.tryParse(value.trim());
                                        if (age == null || age < 5 || age > 100) {
                                          return 'Enter valid age (5–100)';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _heightController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Height',
                                        suffixText: 'cm',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'Enter height';
                                        }
                                        final h = double.tryParse(value.trim());
                                        if (h == null || h < 80 || h > 250) {
                                          return 'Enter 80–250 cm';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Weight',
                                  suffixText: 'kg',
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter weight';
                                  }
                                  final w = double.tryParse(value.trim());
                                  if (w == null || w < 20 || w > 250) {
                                    return 'Enter 20–250 kg';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      value: _goal,
                                      decoration: const InputDecoration(
                                        labelText: 'Fitness Goal',
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'Weight Loss',
                                          child: Text('Weight Loss'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Weight Gain',
                                          child: Text('Weight Gain'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Maintenance',
                                          child: Text('Maintenance'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        if (value == null) return;
                                        setState(() {
                                          _goal = value;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      value: _dietType,
                                      decoration: const InputDecoration(
                                        labelText: 'Diet Type',
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'Veg',
                                          child: Text('Vegetarian'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Non-Veg',
                                          child: Text('Non-Veg'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        if (value == null) return;
                                        setState(() {
                                          _dietType = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton.icon(
                                  onPressed: _calculatePlan,
                                  icon: const Icon(Icons.auto_awesome),
                                  label: const Text('Generate AI Diet Plan'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_bmi != null && _healthStatus != null) ...[
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your BMI & Health Status',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Chip(
                                    label: Text('BMI: ${_bmi!.toStringAsFixed(1)}'),
                                    avatar: const Icon(Icons.monitor_weight_outlined),
                                  ),
                                  const SizedBox(width: 8),
                                  Chip(
                                    label: Text(_healthStatus!),
                                    avatar: const Icon(Icons.health_and_safety_outlined),
                                    backgroundColor: _healthStatus == 'Normal'
                                        ? Colors.green.withOpacity(0.2)
                                        : Colors.orange.withOpacity(0.2),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Goal: $_goal | Diet: $_dietType',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    if (_mealPlan != null) _buildMealPlanSection(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealPlanSection(BuildContext context) {
    final plan = _mealPlan!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personalized Daily Meal Plan',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        ...plan.entries.map((entry) {
          final title = entry.key;
          final items = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              shape: RoundedBorderRadius.all(Radius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    ...items.map(
                      (line) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• '),
                          Expanded(
                            child: Text(
                              line,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}


