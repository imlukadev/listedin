import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;
  final Icon icon;

  const Tag({super.key, required this.text, required this.icon});

  @override
  Widget build(Object context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Row(
        children: [
          icon,
          SizedBox(width: 2),
          Text(text,
              selectionColor: Colors.grey,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
