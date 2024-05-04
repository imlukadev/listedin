import 'package:flutter/material.dart';
import 'package:listedin/app/components/button/button.dart';
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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Button(
          color: primary,
          isLogin: true,
          content: "asd ad as",
          onPressed: () => "",
        ));
  }
}
