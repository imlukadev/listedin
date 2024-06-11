import 'package:flutter/material.dart';

class StatsIcon extends StatelessWidget{

  final Color color;
  final double size;

  const StatsIcon({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context){
    return Icon(Icons.query_stats, color: color, size: size);
  }

}