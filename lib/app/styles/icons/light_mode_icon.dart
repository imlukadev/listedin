import 'package:flutter/material.dart';

class LightModeIcon extends StatelessWidget {
  final Color color;
  final double size;
  const LightModeIcon({super.key, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.light_mode, color: color, size: size);
  }
}
