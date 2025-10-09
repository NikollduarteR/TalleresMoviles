import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/meal.dart';

class MealService {
  //Se obtiene la URL base desde el archivo .env
  final String baseUrl = dotenv
      .env['MEAL_API_URL']!; // (por compatibilidad futura, aunque en esta API ya está incluido)

  /// Buscar comidas por nombre
  Future<List<Meal>> searchMeals({String query = ''}) async {
    try {
      final url = Uri.parse('$baseUrl/search.php?s=$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic>? mealsJson = data['meals'];

        if (mealsJson == null) {
          return []; // No hay resultados
        }

        return mealsJson.map((mj) => Meal.fromJson(mj)).toList();
      } else {
        throw Exception('Error al buscar comidas: ${response.statusCode}');
      }
    } catch (e) {
      // Manejo de errores de red o parseo
      throw Exception('Error de conexión o de datos: $e');
    }
  }

  /// Obtener detalle de una comida por ID
  Future<Meal> getMealDetail(String id) async {
    try {
      final url = Uri.parse('$baseUrl/lookup.php?i=$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic>? mealsJson = data['meals'];

        if (mealsJson != null && mealsJson.isNotEmpty) {
          return Meal.fromJson(mealsJson.first);
        } else {
          throw Exception('No se encontró el detalle de la comida');
        }
      } else {
        throw Exception('Error al obtener detalle: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión o de datos: $e');
    }
  }
}
