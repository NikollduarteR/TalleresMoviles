import 'package:flutter/material.dart';
import 'package:talleres/views/timer/timer_view.dart';
import 'grid_view.dart'; // Ajusta la ruta si es necesario

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.grid_view), text: 'Grid'),
              Tab(icon: Icon(Icons.timer), text: 'Timer'),
              Tab(icon: Icon(Icons.settings), text: 'Ajustes'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Primera pestaña: tu GridViewWidget con 3 elementos
                GridViewWidget(
                  items: const [
                    'Registrarse',
                    'Ciclo de vida',
                    'Future',
                    'Isolate',
                  ],
                ),
                // Segunda pestaña: Timer
                const TimerView(),
                // Tercera pestaña: Ajustes
                const Center(child: Text('Contenido de Ajustes')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
