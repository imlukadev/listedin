// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:listedin/app/components/container.dart';
import 'package:listedin/app/components/header.dart';
import 'package:listedin/app/components/tag.dart';

class LayoutLearning extends StatefulWidget {
  const LayoutLearning({super.key});

  @override
  State<StatefulWidget> createState() => _LayoutLearning();
}

class _LayoutLearning extends State<LayoutLearning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Header(),
      ),
      body: MainContainer(children: [
        SizedBox(height: 24),
        Image.asset(
          'assets/first.png',
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(height: 20),
        Flex(
          direction: Axis.horizontal,
          children: [
            Text("Bantu Banjir Demak Kembali Pulih.",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700))
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: Row(
              children: [
                Tag(
                    text: "10.000",
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      size: 16,
                      color: Colors.grey,
                    )),
                SizedBox(width: 9),
                Tag(
                    text: "Oh my god",
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      size: 16,
                      color: Colors.grey,
                    )),
              ],
            )),
            Row(
              children: [
                Icon(
                  Icons.send_and_archive_outlined,
                  size: 16,
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.list_alt_outlined,
                  size: 16,
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 10),
        Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow,
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange,
                  ),
                  width: 120,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Caralho man",
                    selectionColor: Colors.grey,
                  ),
                ),
                Text(
                  "20 days ago",
                  selectionColor: Colors.grey,
                )
              ],
            )
          ],
        )
      ]),
    );
  }
}
