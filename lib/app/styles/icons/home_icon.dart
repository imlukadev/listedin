import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  final Color color;
  const HomeIcon({super.key, required this.color});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.home_sharp, color: color);
  }
}
