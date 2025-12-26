import 'package:flutter/material.dart';
import '../models/user_stats.dart';
import '../models/meal_plan.dart';
import '../services/diet_service.dart';
import '../theme/app_theme.dart';

class DietPlannerScreen extends StatefulWidget {
  const DietPlannerScreen({super.key});

  @override
  State<DietPlannerScreen> createState() => _DietPlannerScreenState();
}

class _DietPlannerScreenState extends State<DietPlannerScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _goal = 'Weight loss';
  String _dietType = 'Veg';

  UserStats? _stats;
  MealPlan? _mealPlan;

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  Future<void> _calculatePlan() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryGreen),
      ),
    );

    try {
      final stats = UserStats(
        age: int.parse(_ageController.text.trim()),
        heightCm: double.parse(_heightController.text.trim()),
        weightKg: double.parse(_weightController.text.trim()),
        goal: _goal,
        dietType: _dietType,
      );

      final mealPlan = await DietService.buildMealPlan(stats);

      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog

      setState(() {
        _stats = stats;
        _mealPlan = mealPlan;
        _isLoading = false;
      });

      FocusScope.of(context).unfocus();
      _showSuccessPopup();
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate plan. Please try again.')),
      );
    }
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.lightGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: AppTheme.primaryGreen, size: 40),
              ),
              const SizedBox(height: 24),
              const Text(
                'Plan Generated!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your personalized diet plan is ready. Let\'s see it!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showResultModal();
                  },
                  child: const Text('View Plan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.7,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48),
              topRight: Radius.circular(48),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: _buildResultContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('AI PLANNER'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildFormCard(isWide),
                const SizedBox(height: 32),
                _buildInfoBanner(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.lightGreen.withOpacity(0.5),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded, color: AppTheme.primaryGreen, size: 28),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Expert AI Guidance',
                  style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Customized suggestions based on your unique body metrics.',
                  style: TextStyle(
                    color: AppTheme.primaryGreen.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(bool isWide) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Metrics',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppTheme.textDark,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 32),
            if (isWide)
              Row(
                children: [
                  Expanded(child: _buildTextField(_ageController, 'Age', 'yrs')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(_heightController, 'Height', 'cm')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(_weightController, 'Weight', 'kg')),
                ],
              )
            else ...[
              Row(
                children: [
                  Expanded(child: _buildTextField(_ageController, 'Age', 'yrs')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(_heightController, 'Height', 'cm')),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(_weightController, 'Weight', 'kg'),
            ],
            const SizedBox(height: 40),
            _buildSectionHeader('Overall Goal'),
            const SizedBox(height: 16),
            _buildGoalSelector(),
            const SizedBox(height: 32),
            _buildSectionHeader('Dietary Choice'),
            const SizedBox(height: 16),
            _buildDietSelector(),
            const SizedBox(height: 56),
            _buildGenerateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String suffix) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        suffixStyle: const TextStyle(fontWeight: FontWeight.normal, color: AppTheme.textSecondary),
      ),
      validator: (v) => (v == null || v.isEmpty) ? '!' : null,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w900,
        color: AppTheme.textDark,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildGoalSelector() {
    final goals = [
      {'label': 'Weight loss', 'icon': Icons.trending_down_rounded},
      {'label': 'Weight gain', 'icon': Icons.trending_up_rounded},
      {'label': 'Maintenance', 'icon': Icons.balance_rounded},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: goals.map((g) {
          final label = g['label'] as String;
          final icon = g['icon'] as IconData;
          final selected = _goal == label;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              avatar: Icon(icon, size: 16, color: selected ? Colors.white : AppTheme.primaryGreen),
              label: Text(label),
              selected: selected,
              onSelected: (val) {
                if (val) setState(() => _goal = label);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDietSelector() {
    return Row(
      children: [
        _buildDietChip('Vegetarian', 'Veg', Icons.eco_rounded),
        const SizedBox(width: 12),
        _buildDietChip('Non-Veg', 'Non-veg', Icons.restaurant_rounded),
      ],
    );
  }

  Widget _buildDietChip(String label, String value, IconData icon) {
    final selected = _dietType == value;
    return Expanded(
      child: ChoiceChip(
        avatar: Icon(icon, size: 16, color: selected ? Colors.white : AppTheme.primaryGreen),
        label: Center(child: Text(label)),
        selected: selected,
        onSelected: (val) {
          if (val) setState(() => _dietType = value);
        },
      ),
    );
  }

  Widget _buildGenerateButton() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryGreen, Color(0xFF4ADE80)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: FilledButton(
        onPressed: _calculatePlan,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.auto_awesome_rounded),
            SizedBox(width: 12),
            Text('Create My Diet Plan'),
          ],
        ),
      ),
    );
  }

  Widget _buildResultContent() {
    final bmi = _stats!.bmi;
    final status = _stats!.bmiStatus;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.share_rounded, color: AppTheme.primaryGreen, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        const Text(
          'Diet Summary',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppTheme.textDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.lightGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'AI CURATED',
                style: TextStyle(color: AppTheme.primaryGreen, fontSize: 10, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Read below for details',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 32),
        _buildSectionHeader('Nutritional Snapshot'),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2.2,
          children: [
            _buildResultInfoChip(Icons.local_fire_department_rounded, _mealPlan!.calories, AppTheme.accentYellow.withOpacity(0.3)),
            _buildResultInfoChip(Icons.egg_alt_rounded, _mealPlan!.proteins, AppTheme.accentPink.withOpacity(0.3)),
            _buildResultInfoChip(Icons.grass_rounded, _mealPlan!.carbs, AppTheme.lightGreen),
            _buildResultInfoChip(Icons.opacity_rounded, _mealPlan!.fats, Colors.blue[50]!),
          ],
        ),
        const SizedBox(height: 40),
        _buildResponsiveBmiSection(bmi, status),
        const SizedBox(height: 48),
        _buildSectionHeader('Daily Meal Guide'),
        const SizedBox(height: 20),
        ..._mealPlan!.meals.map((meal) => _buildMealItem(meal)),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Save Plan'),
          ),
        ),
      ],
    );
  }

  Widget _buildResultInfoChip(IconData icon, String label, Color bg) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: AppTheme.textDark.withOpacity(0.8)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppTheme.textDark),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveBmiSection(double bmi, String status) {
    Color statusColor = AppTheme.primaryGreen;
    if (status == 'Overweight') statusColor = Colors.orange;
    if (status == 'Underweight') statusColor = Colors.blue;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.textDark,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BODY MASS INDEX',
                  style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                ),
                const SizedBox(height: 8),
                Text(
                  bmi.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealItem(String meal) {
    final isTip = meal.startsWith('Tip:');
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isTip ? AppTheme.accentYellow.withOpacity(0.1) : AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isTip ? Colors.orange.withOpacity(0.1) : AppTheme.lightGreen.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isTip ? Icons.lightbulb_rounded : Icons.restaurant_rounded,
              size: 18,
              color: isTip ? Colors.orange : AppTheme.primaryGreen,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isTip ? 'Health Tip' : 'Recommendation',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: isTip ? Colors.orange : AppTheme.primaryGreen,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meal.replaceFirst('Tip: ', ''),
                  style: TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 15,
                    fontWeight: isTip ? FontWeight.bold : FontWeight.normal,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
