import 'package:flutter/material.dart';
// import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'week_day.dart';

class WeekList extends StatefulWidget {
  final bool darkModeOn;
  final ListRepository listRepository;

  const WeekList({
    super.key,
    required this.darkModeOn,
    required this.listRepository,
  });

  @override
  State<WeekList> createState() => _WeekListState();
}

class _WeekListState extends State<WeekList> {
 

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(7, (index) {
          DateTime date = startOfWeek.add(Duration(days: index));
          return WeekDay(
            date: date,
            darkModeOn: widget.darkModeOn,
            listRepository: widget.listRepository,
          );
        }),
      ),
    );
  }
}
