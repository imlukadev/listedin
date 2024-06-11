import 'package:flutter/material.dart';
import 'package:listedin/app/components/week_day/week_list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';

class DevThiago extends StatefulWidget {
  final String title;
  final ListRepository listRepository;

  const DevThiago({super.key, required this.title, required this.listRepository});

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
      body: Center(
        child: Column(
          children: [
            WeekList(darkModeOn: true, listRepository: widget.listRepository),
          ],
        ),
      ),
    );
  }
}
