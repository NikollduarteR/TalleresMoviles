import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:talleres/widgets/base_view.dart';

class MiCicloVida extends StatefulWidget {
  const MiCicloVida({super.key});

  @override
  State<MiCicloVida> createState() => CicloVidaScreenState();
}

class CicloVidaScreenState extends State<MiCicloVida> {
  String texto = "Texto inicial 🟢";

  // Se ejecuta una sola vez cuando el widget se inserta en el árbol de widgets.
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("🟢 initState() -> La pantalla se ha inicializado");
    }
  }

  // Se ejecuta después de initState y cada vez que cambian las dependencias del widget.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (kDebugMode) {
      print("🟡 didChangeDependencies() -> Tema actual");
    }
  }

  // Se ejecuta cada vez que el widget necesita ser reconstruido.
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("🔵 build() -> Construyendo la pantalla");
    }
    return BaseView(
      title: "Ciclo de Vida en flutter",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(texto, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: actualizarTexto,
              child: const Text("Actualizar"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // O usa context.pop() si usas go_router
              },
              child: const Text("Devolverme"),
            ),
          ],
        ),
      ),
    );
  }

  //actualiza el texto y lo muestra en la pantalla
  void actualizarTexto() {
    setState(() {
      texto = "Texto actualizado 🟠";
      if (kDebugMode) {
        print("🟠 setState() -> Estado actualizado");
      }
    });
  }

  /// Se ejecuta cuando el widget es eliminado de la memoria.
  @override
  void dispose() {
    if (kDebugMode) {
      print("🔴 dispose() -> La pantalla se ha destruido");
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MiCicloVida oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (kDebugMode) {
      print("🟣 didUpdateWidget() -> El widget ha sido actualizado");
    }
  }
}
