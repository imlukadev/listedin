import 'package:flutter/material.dart';
import 'package:listedin/app/components/week_day/week_list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';

class HomePage extends StatefulWidget {

  final ListRepository listRepository;
  final bool darkModeOn;
  const HomePage({super.key, required this.title, required this.listRepository, required this.darkModeOn});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            WeekList(darkModeOn: widget.darkModeOn, listRepository: widget.listRepository)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
