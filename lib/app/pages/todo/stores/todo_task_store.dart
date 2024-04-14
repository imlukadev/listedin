import 'package:flutter/material.dart';
import 'package:listedin/app/data/models/todo_task.dart';
// import 'package:listedin/app/data/repositories/task_repository.dart';
import 'package:listedin/app/data/repositories/todo_task_repository.dart';

class TodoTaskStore {

    final ITodoTaskRepository repository;
    
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //Várivel reativa para o state
  final ValueNotifier<List<TodoTask>> state = ValueNotifier<List<TodoTask>>([]);

  //Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier("");

    Future getTasks() async {
    isLoading.value = true;
    try {
    final result = await repository.getTodoTasks();
    state.value = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  TodoTaskStore({required this.repository});
}
