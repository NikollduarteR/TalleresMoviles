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
            final selected = items[index];
            switch (selected) {
              case 'Registrarse':
                context.push('/registrar');
                break;
              case 'Ciclo de vida':
                context.push('/ciclo_vida_demo');
                break;
              case 'Future':
                context.push('/future');
                break;
              case 'Isolate':
                context.push('/isolate');
                break;
              case 'JWT':
                context.push('/jwt');
                break;
            }
          },
          child: Card(
            color: Color.fromARGB(255, 248, 222, 250),
            child: Center(
              child: Text(
                items[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
