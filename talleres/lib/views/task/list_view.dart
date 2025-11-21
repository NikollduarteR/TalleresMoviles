import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/task_provider.dart';
import '../task/form_view.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("To-Do List")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TaskFormView()),
        ),
      ),
      body: FutureBuilder(
        future: provider.loadTasks(),
        builder: (_, snap) {
          final tasks = provider.tasks;

          if (tasks.isEmpty) {
            return const Center(child: Text("No hay tareas"));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, i) {
              final t = tasks[i];
              return ListTile(
                title: Text(t.title),
                leading: Checkbox(
                  value: t.completed,
                  onChanged: (val) {
                    t.completed = val!;
                    provider.updateTask(t);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => provider.deleteTask(t.id),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TaskFormView(task: t)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
