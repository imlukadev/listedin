import 'package:flutter/material.dart';
import 'package:listedin/app/components/button/button.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/components/input/input.dart';
import 'package:listedin/app/pages/lists/lists.dart';
import 'package:listedin/app/pages/login/login.dart';
import 'package:listedin/app/pages/register/store/register_store.dart';
import 'package:listedin/app/styles/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

 late RegisterStore store;

  @override
  void initState() {
    super.initState();
    store = RegisterStore();
  }

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = const TextStyle(
              color: Color(0xFFA8A8A8),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600, // Semibold
              fontSize: 10,
            );

    return Scaffold(
      // appBar: const Header(),
      body: Center(
        child:       Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text(
            "Cadastre-se",
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
                store.updateName(value);
              },
              keyboardType: TextInputType.name,
              style: textStyle,
              decoration: getCustomInputDecoration('Name'),
            ),
          ),

          SizedBox(
            height: 64,
            width: 350,
            child: TextField(
              onChanged: (value) {
                store.updateEmail(value);
              },
              keyboardType: TextInputType.name,
              style: textStyle,
              decoration: getCustomInputDecoration('Email'),
            ),
          ),


          SizedBox(
            height: 64,
            width: 350,
            child: TextField(
              onChanged: (value) {
                store.updatePassword(value);
              },
              keyboardType: TextInputType.name,
              style: textStyle,
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
                              builder: (context) => const LoginPage(
                                    title: "Login",
                              )),
                        );
                      },
                      child: Text(
                        "Já possui uma conta? clique aqui e faça login!",
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
              // small: true,
              onPressed: () async {
                if (await store.register()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListsPage(user: store.userLogged.value!)),
                  );
                }
              },
              content: 'Fazer Cadastro',
              color: primary),
          )
          
        ],
      ),
      )

    );
  }
}
