// isolate_tarea_pesada_view.dart
import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import '../../widgets/base_view.dart';

/// --- FUNCIÓN PESADA: simulación de proceso largo ---
/// Se ejecuta dentro del isolate (no puede acceder a variables de la UI)
void tareaPesada(SendPort sendPort) async {
  final receive = ReceivePort();
  sendPort.send(receive.sendPort);

  await for (var message in receive) {
    final int limite = message[0];
    final SendPort respuesta = message[1];

    int suma = 0;
    for (int i = 0; i < limite; i++) {
      suma += i;
      if (i % 10000000 == 0) {
        // Simula carga progresiva
        print('Isolate: procesando $i...');
      }
    }

    // Simulamos una demora extra (2 segundos)
    await Future.delayed(const Duration(seconds: 2));

    respuesta.send(suma);
    receive.close();
    Isolate.exit();
  }
}

/// --- VISTA PRINCIPAL ---
class IsolateView extends StatefulWidget {
  const IsolateView({super.key});

  @override
  State<IsolateView> createState() => IsolateViewState();
}

class IsolateViewState extends State<IsolateView> {
  String estado = "Presiona para iniciar la tarea pesada";
  int? resultado;
  bool enProgreso = false;

  Future<void> ejecutarTareaPesada() async {
    setState(() {
      enProgreso = true;
      estado = "Iniciando isolate...";
      resultado = null;
    });

    print("🟡 Antes de crear isolate");
    final receivePort = ReceivePort();

    // Crear el isolate y ejecutar la función
    await Isolate.spawn(tareaPesada, receivePort.sendPort);

    final sendPort = await receivePort.first as SendPort;
    final responsePort = ReceivePort();

    print("🟢 Isolate creado, enviando datos...");
    sendPort.send([
      80000000,
      responsePort.sendPort,
    ]); // 80 millones para hacerlo largo

    // Esperar el resultado
    final res = await responsePort.first as int;

    print("🔵 Resultado recibido: $res");
    print("🔴 Después del isolate");

    if (!mounted) return;
    setState(() {
      resultado = res;
      enProgreso = false;
      estado = "Completado con éxito ✅";
    });

    receivePort.close();
    responsePort.close();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Isolate - Tarea Pesada',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              estado,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            if (enProgreso) const CircularProgressIndicator(),
            const SizedBox(height: 16),
            if (resultado != null)
              Text(
                "Resultado: $resultado",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: enProgreso ? null : ejecutarTareaPesada,
              child: const Text("Ejecutar tarea larga"),
            ),
            const SizedBox(height: 20),
            // 🔙 Botón para regresar
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("Regresar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 248, 222, 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
