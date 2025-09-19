import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrarDetalleScreen extends StatelessWidget {
  final String metodo;
  final String valor;
  const RegistrarDetalleScreen({super.key, required this.metodo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Registro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Método de navegación: $metodo', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Text('Dato recibido: $valor', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.pop(); // Devuelve a la pantalla anterior
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}

