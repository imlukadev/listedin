import 'package:flutter/material.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/repositories/task_repository.dart';
import 'package:listedin/app/pages/todo/todo_app.dart';
import 'package:listedin/app/pages/home/stores/task_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskStore store = TaskStore(
    repository: TaskRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Consumo de APIs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation:
            Listenable.merge([store.isLoading, store.error, store.state]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const CircularProgressIndicator();
          }

          if (store.error.value.isNotEmpty) {
            return Center(
              child: Text(
                store.error.value,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (store.state.value.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum item na lista",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                final task = store.state.value[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TodoApp()));
                  },
                  contentPadding: const EdgeInsets.all(32),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(task.id),
                  ),
                  title: Text(task.name),
                  subtitle: Text(task.createdAt),
                );
              },
              itemCount: store.state.value.length,
            );
          }
        },
      ),
    );
  }
}
