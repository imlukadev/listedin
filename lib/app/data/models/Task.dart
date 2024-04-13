class Task {
  final String name;
  final DateTime createdAt;

  Task({required this.name, required this.createdAt});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(name: map['name'], createdAt: DateTime.parse(map['createdAt']));
  }
}
