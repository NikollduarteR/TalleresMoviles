import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrarScreen extends StatefulWidget {
  const RegistrarScreen({super.key});

  @override
  State<RegistrarScreen> createState() => _RegistrarScreenState();
}

class _RegistrarScreenState extends State<RegistrarScreen> {
  final TextEditingController _controller = TextEditingController();

  void _navegar(BuildContext context, String metodo) {
    final valor = _controller.text.trim();
    if (valor.isEmpty) return;
    final ruta = '/registrar/$metodo/$valor';
    if (metodo == 'go') {
      context.go(ruta);
    } else if (metodo == 'push') {
      context.push(ruta);
    } else if (metodo == 'replace') {
      context.replace(ruta);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ingresa un dato para registrar:'),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Dato',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _navegar(context, 'go'),
                  child: const Text('go'),
                ),
                ElevatedButton(
                  onPressed: () => _navegar(context, 'push'),
                  child: const Text('push'),
                ),
                ElevatedButton(
                  onPressed: () => _navegar(context, 'replace'),
                  child: const Text('replace'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Prueba el botón atrás en la pantalla de detalle para ver la diferencia entre go, push y replace.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
