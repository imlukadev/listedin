import 'package:flutter/material.dart';
import 'package:listedin/app/components/button/button.dart';
import 'package:listedin/app/components/card/card.dart';
import 'package:listedin/app/components/header/header.dart';
import 'package:listedin/app/components/input/input.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/pages/devs/store_luka.dart';
import 'package:listedin/app/styles/colors.dart';

class DevLuka extends StatefulWidget {
  const DevLuka({super.key, required this.title});

  final String title;

  @override
  State<DevLuka> createState() => _DevLukaState();
}

class _DevLukaState extends State<DevLuka> {
  @override
  void initState() {
    super.initState();
    // print();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {},
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Color(0xFFA8A8A8),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600, // Semibold
              fontSize: 10,
            ),
            decoration: getInputDecoration('Digite seu nome!'),
          ),
          TextField(
            onChanged: (value) {},
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Color(0xFF343434),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600, // Semibold
              fontSize: 16,
            ),
            decoration: getInputDecoration('Digite sua senha!'),
          ),
        ],
      ),
    );
  }
}
