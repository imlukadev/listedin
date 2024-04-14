class Task {
  final String id;
  final String name;
  final String createdAt;

  Task({required this.id, required this.name, required this.createdAt});

  // factory Task.fromMap(Map<String, dynamic> map) {
  //   return Task(
  //       id: map['id'].toString(),
  //       name: map['name'],
  //       createdAt: DateTime.parse(map['createdAt']));
  // }

    factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      createdAt: json['createdAt'],
      name: json['name'],
    );
  }
}

