import 'package:flutter/material.dart';

class DarkModeIcon extends StatelessWidget {
  final Color color;
  final double size;
  const DarkModeIcon({super.key, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.dark_mode, color: color, size: size,);
  }
}
