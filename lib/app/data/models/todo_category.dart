import 'package:flutter/material.dart';

class Category {
  final String id;
  final Color color;
  final String name;

  Category({required this.id, required this.color, required this.name});
  
    factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      name: json['name'],
      color: Color(int.parse(json["color"].substring(1), radix: 16) + 0xFF000000),
    );
  }
  
  }
