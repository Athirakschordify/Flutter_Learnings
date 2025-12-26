import 'package:flutter/material.dart';

void main() {
  runApp(const RecipeAIApp());
}

class RecipeAIApp extends StatelessWidget {
  const RecipeAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Offline AI Recipe Finder',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  String result = "";

  // ✅ Offline AI Model: Ingredient → Recipe Map
  final Map<String, Map<String, dynamic>> recipes = {
    "egg, bread, cheese": {
      "name": "Cheese Egg Toast",
      "steps": [
        "Beat the eggs in a bowl",
        "Toast the bread lightly",
        "Place cheese and eggs on toast",
        "Cook on pan for 3-5 minutes"
      ],
      "tips": "Serve hot with ketchup or sauce."
    },
    "rice, egg": {
      "name": "Egg Fried Rice",
      "steps": [
        "Cook rice",
        "Scramble eggs in a pan",
        "Mix rice with eggs and soy sauce"
      ],
      "tips": "Add vegetables for more flavor."
    },
    "tomato, pasta": {
      "name": "Tomato Pasta",
      "steps": [
        "Boil pasta",
        "Prepare tomato sauce",
        "Mix pasta with sauce",
        "Serve hot"
      ],
      "tips": "Add cheese on top for extra taste."
    }
  };

  // ✅ Offline AI Prediction Function
  Map<String, dynamic>? getRecipeFromAI(String ingredients) {
    String input = ingredients.toLowerCase().trim();

    for (var key in recipes.keys) {
      if (key.contains(input) || input.contains(key)) {
        return recipes[key];
      }
    }
    return null;
  }

  void fetchRecipe() {
    if (controller.text.isEmpty) {
      setState(() {
        result = "Please enter some ingredients.";
      });
      return;
    }

    final recipe = getRecipeFromAI(controller.text);

    setState(() {
      if (recipe != null) {
        result =
            "Recipe: ${recipe['name']}\n\nSteps:\n${recipe['steps'].join('\n')}\n\nTips: ${recipe['tips']}";
      } else {
        result = "Sorry! No recipe found for these ingredients.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offline AI Recipe Finder"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Enter ingredients you have 👇",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Eg: Egg, Bread, Cheese",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchRecipe,
              child: const Text("Get Recipe 🍽️"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  result,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
