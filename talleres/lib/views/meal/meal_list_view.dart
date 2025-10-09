import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talleres/models/meal.dart';
import 'package:talleres/services/meal_service.dart';

class MealListView extends StatefulWidget {
  const MealListView({super.key});

  @override
  State<MealListView> createState() => _MealListViewState();
}

class _MealListViewState extends State<MealListView> {
  final MealService _mealService = MealService();
  late Future<List<Meal>> _futureMeals;

  @override
  void initState() {
    super.initState();
    _futureMeals = _mealService.searchMeals(
      query: '',
    ); // buscar todos (o con un término)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listado de Comidas')),
      body: FutureBuilder<List<Meal>>(
        future: _futureMeals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron comidas.'));
          } else {
            final meals = snapshot.data!;
            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return ListTile(
                  leading: Image.network(
                    meal.thumbnail,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(meal.name),
                  subtitle: Text('${meal.category} — ${meal.area}'),
                  onTap: () {
                    context.push('/meal/${meal.id}');
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
