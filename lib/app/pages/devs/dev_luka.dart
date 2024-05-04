import 'package:flutter/material.dart';
import 'package:listedin/app/components/button/button.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/styles/colors.dart';

class DevLuka extends StatefulWidget {
  const DevLuka({super.key, required this.title});

  final String title;

  @override
  State<DevLuka> createState() => _DevLukaState();
}

class _DevLukaState extends State<DevLuka> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Header(),
        body: Button(
          color: primary,
          isLogin: true,
          content: "asd ad as",
          onPressed: () => "",
        ));
  }
}
