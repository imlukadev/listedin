import 'package:flutter/material.dart';

class SearchIcon extends StatelessWidget {
  final Color color;
  final double size;
  const SearchIcon({super.key, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.search, color: color, size: size);
  }
}
