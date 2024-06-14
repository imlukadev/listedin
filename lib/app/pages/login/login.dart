import 'package:flutter/material.dart';
import 'package:listedin/app/components/button/button.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/components/input/input.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/repositories/user_repository.dart';
import 'package:listedin/app/pages/lists/lists.dart';
import 'package:listedin/app/pages/login/store/login_store.dart';
import 'package:listedin/app/pages/register/register.dart';
import 'package:listedin/app/styles/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginStore store;

  @override
  void initState() {
    super.initState();
    store = LoginStore(
      repository: UserRepository(
        HttpClient(),
      ),
    );

    // print();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const Header(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "Login",
              style: TextStyle(
                color: primary,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w900, // Semibold
                fontSize: 32,
              ),
            ),
          
            const SizedBox(
              height: 24,
            ),

            SizedBox(
              height: 64,
              width: 350,
              child: TextField(
                onChanged: (value) {
                  store.updateEmail(value);
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Color(0xFFA8A8A8),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600, // Semibold
                  fontSize: 10,
                ),
                decoration: getCustomInputDecoration('Email'),
              ),
            ),

            SizedBox(
              height: 64,
              width: 350,
              child:  TextField(
                onChanged: (value) {
                  store.updatePassword(value);
                },
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Color(0xFFA8A8A8),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600, // Semibold
                  fontSize: 10,
                ),
                decoration: getCustomInputDecoration('Senha'),
                ),
              ),

              SizedBox(
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage(
                                    title: "Cadastro",
                              )),
                        );
                      },
                      child: Text(
                        "Não possui uma conta? clique aqui e cadastre-se!",
                        style: TextStyle(
                          color: primary,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600, // Semibold
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),


              const SizedBox(
                height: 24,
              ),
           
            SizedBox(
              height: 64,
              width: 350,
              child: Button(
                onPressed: () async {
                  await store.login();
                  if (store.userLogged.value != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListsPage(
                                user: store.userLogged.value!,
                              )),
                    );
                  }
                },
                content: 'Fazer Login',
                color: primary),
            ),
          ],
        ),
      ),
    );
  }
}
