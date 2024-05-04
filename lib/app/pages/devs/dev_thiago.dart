import 'package:flutter/material.dart';
import 'package:listedin/app/components/week_day/week_day.dart';

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
      body:  Center(
        child: Column(
         children: [WeekDay(date: DateTime.now(), darkModeOn: true,)],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
