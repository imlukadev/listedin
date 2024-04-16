import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  final List<Widget> children;

  const MainContainer({super.key, required this.children});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(
                  16)), // Define um raio de 10 para todos os cantos
        ),
        child: Column(children: children),
      ),
    );
  }
}
