import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridViewWidget extends StatelessWidget {
  final List<String> items;
  const GridViewWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (items[index] == 'Registrarse') {
              // Navega a la ruta de registrarse
              context.push('/registrar');
            }
            if (items[index] == 'Ciclo de vida') {
              // Navega a la pantalla de ciclo de vida
              context.push('/ciclo_vida_demo');
            }
          },
          child: Card(
            color: Colors.blue[100],
            child: Center(
              child: Text(items[index], style: const TextStyle(fontSize: 18)),
            ),
          ),
        );
      },
    );
  }
}
