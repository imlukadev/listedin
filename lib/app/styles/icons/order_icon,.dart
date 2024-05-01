import 'package:flutter/material.dart';

class OrderIcon extends StatelessWidget {
  final Color color;
  final double size;
  const OrderIcon({super.key, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.sort, color: color, size: size);
  }
}
