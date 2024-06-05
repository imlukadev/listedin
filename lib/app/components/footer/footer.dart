import 'package:flutter/material.dart';
import 'package:listedin/app/styles/colors.dart';

class Footer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.favorite, color: darkModal, size: 20)
      ],
    );
  }

}