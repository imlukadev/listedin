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
    return const Scaffold(
      appBar: Header(),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
