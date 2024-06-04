import 'package:flutter/material.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/data/repositories/user_repository.dart';
import 'package:listedin/app/pages/devs/dev_luka.dart';
import 'package:listedin/app/pages/devs/dev_saymon.dart';
import 'package:listedin/app/pages/devs/dev_thiago.dart';
import 'package:listedin/app/pages/devs/store_luka.dart';
import 'package:listedin/app/pages/lists/lists.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final IListRepository listRepository = ListRepository(HttpClient());
  final ListStore listStore = ListStore(
    repository: UserRepository(
      HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    listStore.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     // Navegar para a segunda página
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const DevLuka(title: "Opa luka")),
            //     );
            //   },
            //   child: const Text('Vai lá luka'),
            // ),
            ElevatedButton(
              onPressed: () {
                // Navegar para a segunda página
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const DevSaymon(title: "Opa saymon")),
                );
              },
              child: const Text('Vai lá saymon'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar para a segunda página
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ListsPage(user: listStore.state.value)),
                );
              },
              child: const Text('tela listas'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar para a segunda página
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DevThiago(title: "Opa thiago")),
                );
              },
              child: const Text('Vai lá thiago'),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
