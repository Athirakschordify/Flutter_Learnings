import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/user_stats.dart';
import '../models/meal_plan.dart';

class DietService {
  static const String _apiKey = 'AIzaSyBZEzrsv3YS-5itlu5MM4Ky3-sXqfS_leA';

  static Future<MealPlan> buildMealPlan(UserStats stats) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-flash-latest',
        apiKey: _apiKey,
        systemInstruction: Content.system(
          "You are a professional nutritionist. Return ONLY a JSON object with this schema: "
          "{calories: string, proteins: string, carbs: string, fats: string, meals: string[]}. "
          "Provide 5 meals (Breakfast, Mid-morning, Lunch, Evening snack, Dinner) and 1 tip in 'meals'. No markdown."
        ),
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          temperature: 0.2, // Low randomness to reduce hallucination
        ),
      );
      
      final prompt = "Age: ${stats.age}, H: ${stats.heightCm}cm, W: ${stats.weightKg}kg, Goal: ${stats.goal}, Diet: ${stats.dietType}, BMI: ${stats.bmi.toStringAsFixed(1)}";

      final response = await model.generateContent([Content.text(prompt)]);
      
      if (response.text == null || response.text!.isEmpty) return _getFallbackPlan(stats);

      final Map<String, dynamic> data = json.decode(response.text!);
      return MealPlan.fromJson(data);
    } catch (e) {
      print('Gemini Error: $e');
      return _getFallbackPlan(stats);
    }
  }

  static MealPlan _getFallbackPlan(UserStats stats) {
    final isVeg = stats.dietType == 'Veg';
    final meals = stats.goal == 'Weight loss'
        ? (isVeg 
            ? ['Breakfast: Veg Poha', 'Lunch: Dal & 1 Roti', 'Dinner: Veg Soup', 'Tip: Walk 30 mins']
            : ['Breakfast: 2 Egg whites', 'Lunch: Grilled Chicken', 'Dinner: Clear Soup', 'Tip: Walk 30 mins'])
        : ['Breakfast: Oats', 'Lunch: Rice & Dal', 'Dinner: Grilled Paneer', 'Tip: Stay hydrated'];
    
    return MealPlan(
      calories: '1600 Kcal',
      proteins: '80g',
      carbs: '150g',
      fats: '45g',
      meals: meals,
    );
  }
}
