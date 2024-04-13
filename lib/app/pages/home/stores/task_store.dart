import 'package:flutter/material.dart';
import 'package:listedin/app/data/http/exceptions.dart';
import 'package:listedin/app/data/models/Task.dart';
import 'package:listedin/app/data/repositories/task_repository.dart';

class TaskStore {
  final ITaskRepository repository;
  //Variável reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //Várivel reativa para o state
  final ValueNotifier<List<Task>> state = ValueNotifier<List<Task>>([]);

  //Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier("");

  TaskStore({required this.repository});

  Future getTasks() async {
    isLoading.value = true;

    try {
    final result = await repository.getTasks();
    state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
