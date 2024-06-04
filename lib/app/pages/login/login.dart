import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),  
      body: const Center(
        child: Column(
          children: [
            
            Placeholder()
            ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
