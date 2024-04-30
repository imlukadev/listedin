import 'package:flutter/material.dart';

class DevThiago extends StatefulWidget {
  const DevThiago({super.key, required this.title});

  final String title;

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
         children: [Placeholder()],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
