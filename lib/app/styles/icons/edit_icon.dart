import 'package:flutter/material.dart';

class EditIcon extends StatelessWidget {
  final Color color;
  final double size;
  const EditIcon({super.key, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.mode_edit, color: color, size: size);
  }
}
