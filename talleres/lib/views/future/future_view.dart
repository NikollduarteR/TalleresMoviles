import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/base_view.dart';

class FutureView extends StatefulWidget {
  const FutureView({super.key});

  @override
  State<FutureView> createState() => _FutureViewState();
}

class _FutureViewState extends State<FutureView> {
  String estado = "Esperando acción...";
  List<String>? datos; // los datos que se cargarán
  String? error;

  // Simula un servicio que obtiene datos del "servidor"
  Future<List<String>> obtenerDatosDelServidor() async {
    print("➡️ Antes de Future.delayed (inicio de la función)");

    await Future.delayed(const Duration(seconds: 3), () {
      print("➡️ Durante la simulación (Future.delayed ejecutándose)");
    });

    // Simula una respuesta exitosa o con error (50/50)
    final exito = DateTime.now().second % 2 == 0;
    if (exito) {
      print("✅ Datos obtenidos correctamente");
      return ['Manzana', 'Banano', 'Fresa', 'Pera'];
    } else {
      print("❌ Error en la obtención de datos");
      throw Exception("Fallo en la conexión");
    }
  }

  // Función que maneja el flujo completo (asincronía)
  Future<void> cargarDatos() async {
    print("🟢 Antes de llamar a obtenerDatosDelServidor()");
    setState(() {
      estado = "Cargando...";
      datos = null;
      error = null;
    });

    try {
      final resultado =
          await obtenerDatosDelServidor(); // Espera sin bloquear UI
      print("🟡 Después de obtener los datos, antes del setState()");

      if (!mounted) return;
      setState(() {
        estado = "Éxito al cargar datos";
        datos = resultado;
      });
    } catch (e) {
      print("🔴 Se capturó un error: $e");
      if (!mounted) return;
      setState(() {
        estado = "Error al cargar los datos";
        error = e.toString();
      });
    } finally {
      print("🔵 Después del try/catch (bloque finally)");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "Demo Future / async / await",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(estado, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),

              if (datos != null) ...datos!.map((d) => Text("🍎 $d")).toList(),

              if (error != null)
                Text(
                  error!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: cargarDatos,
                child: const Text("Cargar datos simulados"),
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
      ),
    );
  }
}
