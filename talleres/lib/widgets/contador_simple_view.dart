import 'package:flutter/material.dart';

class ContadorSimple extends StatefulWidget {
  const ContadorSimple({super.key});

  @override
  State<ContadorSimple> createState() => _ContadorSimpleState();
}

class _ContadorSimpleState extends State<ContadorSimple> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Contador: $contador', style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => setState(() => contador++),
          child: const Text('Incrementar'),
        ),
      ],
    );
  }
}
