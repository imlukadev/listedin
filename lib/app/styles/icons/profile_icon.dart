import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final Color color;
  final double size;
  const ProfileIcon({super.key, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.manage_accounts, color: color, size: size);
  }
}
