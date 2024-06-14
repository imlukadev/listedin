import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:listedin/app/components/footer/footer.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/pages/devs/dev_saymon.dart';
import 'package:listedin/app/pages/devs/dev_thiago.dart';
import 'package:listedin/app/data/repositories/user_repository.dart';
import 'package:listedin/app/pages/devs/store_luka.dart';
import 'package:listedin/app/pages/lists/lists.dart';

import 'package:listedin/app/pages/login/login.dart';
import 'package:listedin/app/pages/products/products.dart';
import 'package:listedin/app/pages/register/register.dart';
import 'package:listedin/app/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  
  final httpClient = HttpClient();
  final listRepository = ListRepository(httpClient);


  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        iconTheme: IconThemeData(
          color: white, // Defina a cor que você deseja aqui
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title,});

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
            ElevatedButton(
              onPressed: () {
                // Navegar para a segunda página
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginPage(title: "Opa luka")),
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
                      builder: (context) =>
                          ListsPage(user: listStore.state.value)),
                );
              },
              child: const Text('tela listas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage(
                            title: "Cadastre-se",
                          )),

                );
              },
              child: const Text('Vai lá thiago'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer( isDark: false,),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:listedin/app/components/combobox/combobox.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text("DropdownButton Example")),
//         body:  MyCombobox(),
//       ),
//     );
//   }
// }