import 'package:flutter/material.dart';
import 'package:listedin/app/styles/colors.dart';

class FavoriteIcon extends StatelessWidget {
  final Color color;
  final double size;
  final bool isFavorited;
  const FavoriteIcon(
      {super.key,
      required this.color,
      required this.size,
      required this.isFavorited});
  @override
  Widget build(BuildContext context) {
    return isFavorited
        ? Icon(Icons.favorite, color: color, size: size)
        : Icon(Icons.favorite_outline, color: text, size: size);
  }
}
