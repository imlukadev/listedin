import 'package:flutter/material.dart';
import 'package:listedin/app/pages/register/register.dart';
import 'package:listedin/app/pages/user_store/user_store.dart';

class DevThiago extends StatefulWidget {
  final String title;
    final UserStore userStore;

  const DevThiago({super.key, required this.title, required this.userStore});

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
      body: const Placeholder(),
    );
  }
}
