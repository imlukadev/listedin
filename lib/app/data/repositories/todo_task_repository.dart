import 'dart:convert';

import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/models/todo_task.dart';

abstract class ITodoTaskRepository {
  Future<List<TodoTask>> getTodoTasks();
}

class TodoTaskRepository implements ITodoTaskRepository {
  final IHttpClient client;

  TodoTaskRepository({required this.client});
  @override
  Future<List<TodoTask>> getTodoTasks() async {
    final response = await client.get(
        url: "https://run.mocky.io/v3/b8976bae-709e-4734-ae21-bf12650f14c4");
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((taskJson) => TodoTask.fromJson(taskJson)).toList();
    } else {
      throw Exception('Não foi possível carregar as tarefas');
    }
  }
}
