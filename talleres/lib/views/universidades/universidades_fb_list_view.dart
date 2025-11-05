import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/universidades_fb.dart';
import '../../services/universidades_service.dart';

class UniversidadFbListView extends StatelessWidget {
  const UniversidadFbListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Universidades')),
      body: StreamBuilder<List<UniversidadFb>>(
        stream: UniversidadService.watchUniversidades(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final universidades = snapshot.data ?? [];

          if (universidades.isEmpty) {
            return const Center(
              child: Text('No hay universidades registradas.'),
            );
          }

          return ListView.builder(
            itemCount: universidades.length,
            itemBuilder: (context, i) {
              final uni = universidades[i];
              return Card(
                child: ListTile(
                  title: Text(uni.nombre),
                  subtitle: Text('NIT: ${uni.nit}\n${uni.direccion}'),
                  isThreeLine: true,
                  onTap: () => context.push('/universidadesfb/edit/${uni.id}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await UniversidadService.deleteUniversidad(uni.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Eliminada ${uni.nombre}')),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/universidadesfb/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
