import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/task.dart';

class TaskService {
  static Database? _db;

  /// Base URL obtenida desde el archivo .env
  static String get baseUrl {
    final url = dotenv.env['TASK_API_URL'];
    if (url == null || url.isEmpty) {
      throw Exception(
        "❌ ERROR: No se encontró TASK_API_URL en el archivo .env.\n"
        "Agrega: TASK_API_URL=https://tu-api.com",
      );
    }
    return url;
  }

  /// Inicialización SQLite
  static Future<void> init() async {
    final path = join(await getDatabasesPath(), "tasks.db");

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            completed INTEGER NOT NULL,
            updated_at TEXT NOT NULL,
            deleted INTEGER NOT NULL DEFAULT 0
          );
        ''');

        await db.execute('''
          CREATE TABLE queue_operations (
            id TEXT PRIMARY KEY,
            entity_id TEXT,
            op TEXT,
            payload TEXT,
            created_at INTEGER,
            attempt_count INTEGER,
            last_error TEXT
          );
        ''');
      },
    );
  }

  static Database get db => _db!;

  // -------------------------
  // LOCAL CRUD
  // -------------------------

  static Future<void> saveLocal(Task task) async {
    await db.insert("tasks", {
      "id": task.id,
      "title": task.title,
      "completed": task.completed ? 1 : 0,
      "updated_at": task.updatedAt,
      "deleted": task.deleted ? 1 : 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Task>> getLocalTasks() async {
    final res = await db.query("tasks", where: "deleted = 0");

    return res
        .map(
          (e) => Task(
            id: e["id"] as String,
            title: e["title"] as String,
            completed: e["completed"] == 1,
            updatedAt: e["updated_at"] as String,
            deleted: e["deleted"] == 1,
          ),
        )
        .toList();
  }

  static Future<void> markLocalDeleted(String id) async {
    await db.update("tasks", {"deleted": 1}, where: "id = ?", whereArgs: [id]);
  }

  // -------------------------
  // REMOTE CRUD
  // -------------------------

  static Future<bool> sendToAPI(
    String endpoint,
    String method, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final uri = Uri.parse("${baseUrl}$endpoint");
      final headers = {"Content-Type": "application/json"};
      final encodedBody = jsonEncode(body);

      http.Response response;

      switch (method) {
        case "POST":
          response = await http.post(uri, headers: headers, body: encodedBody);
          break;
        case "PUT":
          response = await http.put(uri, headers: headers, body: encodedBody);
          break;
        case "DELETE":
          response = await http.delete(uri, headers: headers);
          break;
        default:
          return false;
      }

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      print("Error enviando a API: $e");
      return false;
    }
  }

  // -------------------------
  // QUEUE SYSTEM
  // -------------------------

  static Future<void> queueOperation(
    String entityId,
    String op,
    Map<String, dynamic> payload,
  ) async {
    await db.insert("queue_operations", {
      "id": DateTime.now().microsecondsSinceEpoch.toString(),
      "entity_id": entityId,
      "op": op,
      "payload": jsonEncode(payload),
      "created_at": DateTime.now().millisecondsSinceEpoch,
      "attempt_count": 0,
      "last_error": "",
    });
  }

  static Future<void> processQueue() async {
    final ops = await db.query("queue_operations");

    for (var op in ops) {
      final id = op["id"] as String;
      final entityId = op["entity_id"] as String;
      final action = op["op"] as String;
      final payload = jsonDecode(op["payload"] as String);

      bool ok = false;

      if (action == "CREATE") {
        ok = await sendToAPI("/tasks", "POST", body: payload);
      } else if (action == "UPDATE") {
        ok = await sendToAPI("/tasks/$entityId", "PUT", body: payload);
      } else if (action == "DELETE") {
        ok = await sendToAPI("/tasks/$entityId", "DELETE");
      }

      if (ok) {
        await db.delete("queue_operations", where: "id = ?", whereArgs: [id]);
      }
    }
  }

  // -------------------------
  // PUBLIC INTERFACE
  // -------------------------

  static Future<void> createTask(Task task) async {
    await saveLocal(task);
    await queueOperation(task.id, "CREATE", task.toJson());
    await processQueue();
  }

  static Future<void> updateTask(Task task) async {
    task.updatedAt = DateTime.now().toIso8601String();
    await saveLocal(task);
    await queueOperation(task.id, "UPDATE", task.toJson());
    await processQueue();
  }

  static Future<void> deleteTask(String id) async {
    await markLocalDeleted(id);
    await queueOperation(id, "DELETE", {});
    await processQueue();
  }
}
