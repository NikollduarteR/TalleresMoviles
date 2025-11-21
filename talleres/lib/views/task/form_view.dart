import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../models/task.dart';
import '../../provider/task_provider.dart';

class TaskFormView extends StatefulWidget {
  final Task? task;

  const TaskFormView({super.key, this.task});

  @override
  State<TaskFormView> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends State<TaskFormView> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.task?.title ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? "Nueva tarea" : "Editar tarea"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.task == null) {
                  provider.addTask(
                    Task(
                      id: const Uuid().v4(),
                      title: controller.text,
                      completed: false,
                      updatedAt: DateTime.now().toIso8601String(),
                    ),
                  );
                } else {
                  widget.task!.title = controller.text;
                  provider.updateTask(widget.task!);
                }

                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
