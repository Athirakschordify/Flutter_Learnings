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
      title: 'AI Recipe App Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const RecipeHomePage(),
    );
  }
}

class RecipeHomePage extends StatefulWidget {
  const RecipeHomePage({super.key});

  @override
  State<RecipeHomePage> createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  final TextEditingController ingredientsController = TextEditingController();
  String result = "";
  bool loading = false;

  // ✅ Hard-coded mock recipes
  Map<String, String> mockRecipes = {
    "egg, onion, tomato":
        "🍳 Tomato Omelette:\n1. Beat 2 eggs\n2. Chop onion and tomato\n3. Mix and cook in a pan\n4. Serve hot",
    "milk, flour, sugar":
        "🥞 Pancakes:\n1. Mix 1 cup flour, 1 cup milk, 2 tbsp sugar\n2. Heat a pan\n3. Pour batter and cook both sides\n4. Serve with syrup",
    "chicken, garlic, pepper":
        "🍗 Garlic Chicken:\n1. Marinate chicken with crushed garlic and pepper\n2. Fry in a pan until golden\n3. Serve with rice"
  };

  void generateRecipe() {
    final input = ingredientsController.text.trim().toLowerCase();

    if (input.isEmpty) {
      setState(() {
        result = "Please enter ingredients separated by commas.";
      });
      return;
    }

    setState(() {
      loading = true;
      result = "";
    });

    // Simulate AI delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        result = mockRecipes[input] ??
            "Sorry! No recipe found for these ingredients. Try something else.";
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Recipe App Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: ingredientsController,
              decoration: const InputDecoration(
                hintText: "Enter ingredients (e.g., egg, onion, tomato)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: generateRecipe,
              child: const Text("Generate Recipe"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Text(
                        result,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
