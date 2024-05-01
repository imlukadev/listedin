import 'package:flutter/material.dart';

class DeleteIcon extends StatelessWidget {
  final Color color;
  final double size;
  const DeleteIcon({super.key, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.delete, color: color, size: size);
  }
}
