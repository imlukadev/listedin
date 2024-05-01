import 'package:flutter/material.dart';

class ProductsIcon extends StatelessWidget{
  final Color color;
  final double size;
  
  const ProductsIcon({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.shopping_basket, color: color, size: size,);
  }

}