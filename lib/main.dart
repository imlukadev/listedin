import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/pages/devs/dev_luka.dart';
import 'package:listedin/app/pages/devs/dev_saymon.dart';
import 'package:listedin/app/pages/devs/dev_thiago.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  
  final httpClient = HttpClient();
  final listRepository = ListRepository(httpClient);

  runApp(MyApp(listRepository: listRepository));
}

class MyApp extends StatelessWidget {
  final ListRepository listRepository;

  const MyApp({super.key, required this.listRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', listRepository: listRepository),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final ListRepository listRepository;

  const MyHomePage({super.key, required this.title, required this.listRepository});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DevLuka(title: "Opa luka")),
                );
              },
              child: const Text('Vai lá luka'),
            ),
            ElevatedButton(
              onPressed: () {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DevThiago(
                            title: "Opa thiago",
                            listRepository: widget.listRepository,
                          )),
                );
              },
              child: const Text('Vai lá thiago'),
            ),
          ],
        ),
      ),
    );
  }
}
