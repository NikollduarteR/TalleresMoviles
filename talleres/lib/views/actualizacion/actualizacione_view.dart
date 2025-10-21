import 'package:flutter/material.dart';

class ActualizacionesView extends StatelessWidget {
  const ActualizacionesView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> actualizaciones = [
      {
        'version': '1.3.0',
        'fecha': '20 de Octubre de 2025',
        'descripcion':
            '🌟 Nuevo diseño del menú lateral, mejoras de rendimiento y corrección de errores menores.',
      },
      {
        'version': '1.2.0',
        'fecha': '05 de Octubre de 2025',
        'descripcion':
            '⚙️ Se agregó el módulo de configuración con soporte para temas claros y oscuros.',
      },
      {
        'version': '1.1.0',
        'fecha': '15 de Septiembre de 2025',
        'descripcion':
            '👤 Nueva sección de perfil con edición de datos de usuario.',
      },
      {
        'version': '1.0.0',
        'fecha': '01 de Septiembre de 2025',
        'descripcion':
            '🚀 Lanzamiento inicial de la aplicación con funciones básicas.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizaciones'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: actualizaciones.length,
        itemBuilder: (context, index) {
          final item = actualizaciones[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  item['version']!,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              title: Text(
                item['fecha']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(item['descripcion']!),
              ),
            ),
          );
        },
      ),
    );
  }
}
