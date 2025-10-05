import 'dart:async';
import 'package:flutter/material.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => TimerViewState();
}

class TimerViewState extends State<TimerView> {
  int segundos = 0;
  Timer? _timer;
  bool corriendo = false;

  void iniciar() {
    if (_timer != null && _timer!.isActive) return;
    setState(() => corriendo = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => segundos++);
    });
  }

  void pausar() {
    _timer?.cancel();
    setState(() => corriendo = false);
  }

  void reanudar() {
    if (!corriendo) iniciar();
  }

  void reiniciar() {
    _timer?.cancel();
    setState(() {
      segundos = 0;
      corriendo = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutos = (segundos ~/ 60).toString().padLeft(2, '0');
    final seg = (segundos % 60).toString().padLeft(2, '0');

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$minutos:$seg',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 245, 183, 250),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: corriendo ? null : iniciar,
                child: const Text('Iniciar'),
              ),
              ElevatedButton(
                onPressed: corriendo ? pausar : null,
                child: const Text('Pausar'),
              ),
              ElevatedButton(
                onPressed: !corriendo && segundos > 0 ? reanudar : null,
                child: const Text('Reanudar'),
              ),
              ElevatedButton(
                onPressed: segundos > 0 ? reiniciar : null,
                child: const Text('Reiniciar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
