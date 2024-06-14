import 'package:flutter/material.dart';
import 'package:listedin/app/pages/register/register.dart';

class DevThiago extends StatefulWidget {
  final String title;

  const DevThiago({super.key, required this.title,});

  @override
  State<DevThiago> createState() => _DevThiagoState();
}

class _DevThiagoState extends State<DevThiago> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          children: [
            RegisterPage(title: "Cadastre-se")
          ],
        ),
      ),
    );
  }
}
