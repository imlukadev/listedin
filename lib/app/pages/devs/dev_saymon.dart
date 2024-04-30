import 'package:flutter/material.dart';


class DevSaymon extends StatefulWidget {
  const DevSaymon({super.key, required this.title});

  final String title;

  @override
  State<DevSaymon> createState() => _DevSaymonState();
}

class _DevSaymonState extends State<DevSaymon> {


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
