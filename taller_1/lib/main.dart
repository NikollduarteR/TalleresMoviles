import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intro Flutter',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'Hola, Flutter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nombre en un Container estilizado
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Estudiante: Nikoll Ximena Duarte Rivera',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            // Row con 2 imágenes: una de red y otra de assets
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  'https://media.istockphoto.com/id/1313842965/es/foto/alerta-negro-cocker-spaniel-cachorro-mirando-a-un-lado.jpg?s=612x612&w=0&k=20&c=Oit5oDpS2nSHQ-v8mO86GRIwOSGKWUs3dUoT-LswRwk=',
                  width: 150,
                  height: 200,
                ),
                Image.asset('assets/images.jfif', width: 150, height: 200),
              ],
            ),
            const SizedBox(height: 24),
            // Botón para cambiar el título
            ElevatedButton(
              onPressed: () {
                setState(() {
                  title = (title == 'Hola, Flutter')
                      ? '¡Título cambiado!'
                      : 'Hola, Flutter';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Título actualizado')),
                );
              },
              child: const Text('Cambiar título'),
            ),
            const SizedBox(height: 24),
            // ListView expandido con íconos y texto
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.blue),
                    title: Text('Perfil de usuario'),
                  ),
                  ListTile(
                    leading: Icon(Icons.school, color: Colors.green),
                    title: Text('Cursos inscritos'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.grey),
                    title: Text('Configuración'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
