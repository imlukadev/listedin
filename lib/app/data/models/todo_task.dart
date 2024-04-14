import 'package:listedin/app/data/models/todo_category.dart';

class TodoTask {
  final String id;
  final String name;
   bool completed;
  final Category category;

  TodoTask(
      {required this.id,
      required this.name,
      required this.completed,
      required this.category});

  factory TodoTask.fromJson(Map<String, dynamic> json) {
    return TodoTask(
      id: json['id'].toString(),
      name: json['name'],
      completed: json['completed'],
      category: Category.fromJson(json['category']),
    );
  }
}
