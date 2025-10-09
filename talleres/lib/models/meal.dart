/// Modelo para representar una comida (Meal) de la API TheMealDB
class Meal {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;

  // Constructor con parámetros requeridos
  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
  });

  // Método factory para crear una instancia de Meal desde un JSON
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? 'Sin nombre',
      category: json['strCategory'] ?? 'Sin categoría',
      area: json['strArea'] ?? 'Desconocida',
      instructions: json['strInstructions'] ?? 'Sin instrucciones',
      thumbnail: json['strMealThumb'] ?? '',
    );
  }
}
