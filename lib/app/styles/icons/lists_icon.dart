import 'package:flutter/material.dart';

class ListsIcon extends StatelessWidget{
  final Color color;
  final double size;

  const ListsIcon({super.key, required this.color, required this.size}); 
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.format_list_bulleted_add, color: color, size: size);
  }

}