import 'package:flutter/material.dart';
import 'package:talleres/widgets/tab_bar_view.dart';
import '../../widgets/custom_drawer.dart';
// Importa tu widget

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Principal')),
      drawer: const CustomDrawer(),
      body: const TabBarScreen(), // Aquí llamas tu TabBarView
    );
  }
}
