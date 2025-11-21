class Task {
  final String id;
  String title;
  bool completed;
  String updatedAt;
  bool deleted;

  Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.updatedAt,
    this.deleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    completed: json['completed'],
    updatedAt: json['updatedAt'],
    deleted: json['deleted'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "completed": completed,
    "updatedAt": updatedAt,
    "deleted": deleted,
  };
}
