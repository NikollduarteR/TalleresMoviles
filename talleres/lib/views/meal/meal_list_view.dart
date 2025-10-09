import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('Comidas disponibles')),
      body: FutureBuilder<List<Meal>>(
        future: _futureMeals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //  Estado de carga
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            //  Estado de error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //  Si no hay datos
            return const Center(child: Text('No se encontraron comidas.'));
          }

          // Estado de éxito (datos cargados)
          final meals = snapshot.data!;
          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return ListTile(
                title: Text(meal.name),
                subtitle: Text(meal.category),
                leading: Image.network(meal.thumbnail, width: 60),
                onTap: () {
                  // ir al detalle
                },
              );
            },
          );
        },
      ),
    );
  }
}
