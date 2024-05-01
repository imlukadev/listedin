import 'package:flutter/material.dart';

class FilterIcon extends StatelessWidget {
  final Color color;
  final double size;
  const FilterIcon({super.key, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.filter_alt, color: color, size: size);
  }
}
