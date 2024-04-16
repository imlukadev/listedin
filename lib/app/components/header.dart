import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.arrow_back_ios),
        actions: const [Icon(Icons.favorite_border_outlined)],
        centerTitle: true,
        title: const Text("Details"),
      ),
    );
  }
}
