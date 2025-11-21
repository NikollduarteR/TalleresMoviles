import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/db_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> tasks = [];

  Future<void> loadTasks() async {
    tasks = await TaskService.getLocalTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await TaskService.createTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await TaskService.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await TaskService.deleteTask(id);
    await loadTasks();
  }
}
