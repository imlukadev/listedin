import 'package:flutter/material.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key, required this.title});

  final String title;

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
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
