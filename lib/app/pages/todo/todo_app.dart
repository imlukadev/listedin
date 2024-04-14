import 'package:flutter/material.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/repositories/todo_task_repository.dart';
import 'package:listedin/app/pages/todo/stores/todo_task_store.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<StatefulWidget> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TodoTaskStore store = TodoTaskStore(
    repository: TodoTaskRepository(
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: AnimatedBuilder(
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
                return Column(
                  children: [
                    const Divider(height: 8),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final task = store.state.value[index];
                        if (task.completed == false) {
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            background: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(48, 16, 48, 16),
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            secondaryBackground: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(48, 16, 48, 16),
                              color: Colors.green,
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              setState(() {
                                final int index =
                                    store.state.value.indexOf(task);
                                store.state.value[index].completed = true;
                              });
                            },
                            key: Key(task.id),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const TodoApp()));
                              },
                              contentPadding:
                                  const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              leading: CircleAvatar(
                                backgroundColor: task.category.color,
                                child: Text(task.id,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                              title: Text(
                                task.name,
                              ),
                              subtitle: Text(task.category.name),
                            ),
                          );
                        } else {
                          return SizedBox
                              .shrink(); // Adiciona isso para ocultar as tarefas concluídas
                        }
                      },
                      itemCount: store.state.value
                          .where((task) => !task.completed)
                          .length, // Atualiza o itemCount para refletir apenas as tarefas não concluídas
                    ),
                    const Divider(height: 8),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final task = store.state.value[index];
                        if (task.completed == true) {
                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(48, 16, 48, 16),
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              setState(() {
                                final int index =
                                    store.state.value.indexOf(task);
                                store.state.value[index].completed = false;
                              });
                            },
                            key: Key(task.id),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const TodoApp()));
                              },
                              contentPadding:
                                  const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              leading: CircleAvatar(
                                backgroundColor: task.category.color,
                                child: Text(task.id,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                              title: Text(
                                task.name,
                              ),
                              subtitle: Text(task.category.name),
                            ),
                          );
                        } else {
                          return SizedBox
                              .shrink(); // Adiciona isso para ocultar as tarefas não concluídas
                        }
                      },
                      itemCount: store.state.value
                          .where((task) => task.completed)
                          .length, // Atualiza o itemCount para refletir apenas as tarefas concluídas
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );

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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: AnimatedBuilder(
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
                return Column(
                  children: [
                    const Divider(height: 8),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final task = store.state.value[index];
                        if (task.completed == false) {
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            background: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(48, 16, 48, 16),
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            secondaryBackground: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(48, 16, 48, 16),
                              color: Colors.green,
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              setState(() {
                                final int index =
                                    store.state.value.indexOf(task);
                                store.state.value[index].completed = true;
                              });
                            },
                            key: Key(task.id),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const TodoApp()));
                              },
                              contentPadding:
                                  const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              leading: CircleAvatar(
                                backgroundColor: task.category.color,
                                child: Text(task.id,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                              title: Text(
                                task.name,
                              ),
                              subtitle: Text(task.category.name),
                            ),
                          );
                        } else {
                          return null;
                        }
                      },
                      itemCount: store.state.value.length,
                    ),
                    const Divider(height: 8),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final task = store.state.value[index];
                        if (task.completed == true) {
                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(48, 16, 48, 16),
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              setState(() {
                                final int index =
                                    store.state.value.indexOf(task);
                                store.state.value[index].completed = false;
                              });
                            },
                            key: Key(task.id),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const TodoApp()));
                              },
                              contentPadding:
                                  const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              leading: CircleAvatar(
                                backgroundColor: task.category.color,
                                child: Text(task.id,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                              title: Text(
                                task.name,
                              ),
                              subtitle: Text(task.category.name),
                            ),
                          );
                        } else {
                          return null;
                        }
                      },
                      itemCount: store.state.value.length,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );

    //   return Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.deepPurple,
    //       title: const Text(
    //         'Consumo de APIs',
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     ),
    //     body: Container(
    //       alignment: Alignment.center,
    //       child: AnimatedBuilder(
    //         animation:
    //             Listenable.merge([store.isLoading, store.error, store.state]),
    //         builder: (context, child) {
    //           if (store.isLoading.value) {
    //             return const CircularProgressIndicator();
    //           }

    //           if (store.error.value.isNotEmpty) {
    //             return Center(
    //               child: Text(
    //                 store.error.value,
    //                 style: const TextStyle(
    //                   color: Colors.black54,
    //                   fontWeight: FontWeight.w600,
    //                   fontSize: 20,
    //                 ),
    //                 textAlign: TextAlign.center,
    //               ),
    //             );
    //           }

    //           if (store.state.value.isEmpty) {
    //             return const Center(
    //               child: Text(
    //                 "Nenhum item na lista",
    //                 style: TextStyle(
    //                   color: Colors.black54,
    //                   fontWeight: FontWeight.w600,
    //                   fontSize: 20,
    //                 ),
    //                 textAlign: TextAlign.center,
    //               ),
    //             );
    //           } else {
    //             return SingleChildScrollView(
    //               child: Column(
    //                 children: [
    //                   // Title(color: Colors.black54, child: const Text("A Fazer")),
    //                   const Divider(
    //                     height: 8,
    //                   ),
    //                   ListView.builder(
    //                     itemBuilder: (context, index) {
    //                       final task = store.state.value[index];
    //                       if (task.completed == true) {
    //                         return Dismissible(
    //                           direction: DismissDirection.endToStart,
    //                           background: Container(
    //                             padding:
    //                                 const EdgeInsets.fromLTRB(48, 16, 48, 16),
    //                             color: Colors.red,
    //                             alignment: Alignment.centerLeft,
    //                             child: const Icon(
    //                               Icons.delete,
    //                               color: Colors.white,
    //                             ),
    //                           ),
    //                           secondaryBackground: Container(
    //                             padding:
    //                                 const EdgeInsets.fromLTRB(48, 16, 48, 16),
    //                             color: Colors.green,
    //                             alignment: Alignment.centerRight,
    //                             child: const Icon(
    //                               Icons.shopping_bag,
    //                               color: Colors.white,
    //                             ),
    //                           ),
    //                           onDismissed: (direction) {
    //                             setState(() {
    //                               final int index =
    //                                   store.state.value.indexOf(task);
    //                               store.state.value[index].completed = true;
    //                             });
    //                           },
    //                           key: Key(task.id),
    //                           child: ListTile(
    //                             onTap: () {
    //                               Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) => const TodoApp()));
    //                             },
    //                             contentPadding:
    //                                 const EdgeInsets.fromLTRB(32, 8, 32, 8),
    //                             leading: CircleAvatar(
    //                               backgroundColor: task.category.color,
    //                               child: Text(task.id,
    //                                   style:
    //                                       const TextStyle(color: Colors.white)),
    //                             ),
    //                             title: Text(
    //                               task.name,
    //                             ),
    //                             subtitle: Text(task.category.name),
    //                           ),
    //                         );
    //                       } else {
    //                         return const Text("WTF");
    //                       }
    //                     },
    //                     itemCount: store.state.value.length,
    //                   ),
    //                   // Title(color: Colors.black54, child: const Text("Feitas")),
    //                   const Divider(
    //                     height: 8,
    //                   ),
    //                   ListView.builder(
    //                     itemBuilder: (context, index) {
    //                       final task = store.state.value[index];
    //                       if (task.completed == false) {
    //                         return Dismissible(
    //                           direction: DismissDirection.startToEnd,
    //                           background: Container(
    //                             padding:
    //                                 const EdgeInsets.fromLTRB(48, 16, 48, 16),
    //                             color: Colors.red,
    //                             alignment: Alignment.centerLeft,
    //                             child: const Icon(
    //                               Icons.delete,
    //                               color: Colors.white,
    //                             ),
    //                           ),
    //                           onDismissed: (direction) {
    //                             setState(() {
    //                               final int index =
    //                                   store.state.value.indexOf(task);
    //                               store.state.value[index].completed = false;
    //                             });
    //                           },
    //                           key: Key(task.id),
    //                           child: ListTile(
    //                             onTap: () {
    //                               Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) => const TodoApp()));
    //                             },
    //                             contentPadding:
    //                                 const EdgeInsets.fromLTRB(32, 8, 32, 8),
    //                             leading: CircleAvatar(
    //                               backgroundColor: task.category.color,
    //                               child: Text(task.id,
    //                                   style:
    //                                       const TextStyle(color: Colors.white)),
    //                             ),
    //                             title: Text(
    //                               task.name,
    //                             ),
    //                             subtitle: Text(task.category.name),
    //                           ),
    //                         );
    //                       } else {
    //                         return null;
    //                       }
    //                     },
    //                     itemCount: store.state.value.length,
    //                   ),
    //                 ],
    //               ),
    //             );
    //           }
    //         },
    //       ),
    //     ),
    //   );
    // }
  }
}
