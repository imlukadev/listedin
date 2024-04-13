import 'dart:convert';
import 'package:listedin/app/data/http/exceptions.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/models/Task.dart';

abstract class ITaskRepository {
  Future<List<Task>> getTasks();
}

class TaskRepository implements ITaskRepository {
  final IHttpClient client;

  TaskRepository({required this.client});
  @override
  Future<List<Task>> getTasks() async {
    final response = await client.get(
        url: 'https://6619b6df125e9bb9f29a9dfc.mockapi.io/api/luka/task');
    if (response.statusCode == 200) {
      // final List<Task> tasks = [];
      final body = jsonDecode(response.body);
      final List<Task> tasks = (body as List<dynamic>).map((item) {
        // print(item);
        return Task.fromMap(item);
      }).toList();

      return tasks;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é valida.');
    } else {
      throw Exception('Não foi possível carregar as tarefas');
    }
  }
}
