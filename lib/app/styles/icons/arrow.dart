import 'package:flutter/material.dart';
import 'package:listedin/app/styles/colors.dart';

class ArrowIcon extends StatelessWidget {
  final Color color;
  final double size;
  const ArrowIcon({
    super.key,
    required this.color,
    required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.arrow_back, color: color, size: size);
  }
}
