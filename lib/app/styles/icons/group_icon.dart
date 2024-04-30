import 'package:flutter/material.dart';

class GroupIcon extends StatelessWidget {
  final Color color;
  final double size;
  const GroupIcon({super.key, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.view_compact_alt, color: color, size: size);
  }
}
