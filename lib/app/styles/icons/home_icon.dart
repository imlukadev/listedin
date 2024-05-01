import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  final Color color;
  final double size;
  const HomeIcon({super.key, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.home_sharp, color: color, size: size);
  }
}
