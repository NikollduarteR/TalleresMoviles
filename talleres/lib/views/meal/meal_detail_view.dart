import 'package:flutter/material.dart';
import 'package:talleres/models/meal.dart';
import 'package:talleres/services/meal_service.dart';

class MealDetailView extends StatefulWidget {
  final String mealId;

  const MealDetailView({super.key, required this.mealId});

  @override
  State<MealDetailView> createState() => _MealDetailViewState();
}

class _MealDetailViewState extends State<MealDetailView> {
  final MealService _mealService = MealService();
  late Future<Meal> _futureMeal;

  @override
  void initState() {
    super.initState();
    _futureMeal = _mealService.getMealDetail(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Comida')),
      body: FutureBuilder<Meal>(
        future: _futureMeal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontró la comida.'));
          } else {
            final meal = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(meal.thumbnail),
                  const SizedBox(height: 16),
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Categoría: ${meal.category}'),
                  Text('Región: ${meal.area}'),
                  const SizedBox(height: 16),
                  const Text(
                    'Instrucciones:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(meal.instructions),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
