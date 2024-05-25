import 'dart:io';

import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';

import 'package:listedin/app/styles/colors.dart';

class CardBuy extends StatelessWidget {
  final bool isDarkMode;
  final bool isList;
  final ShopList? list;
  final Product? product;

  const CardBuy(
      {super.key,
      this.isDarkMode = false,
      this.isList = false,
      this.list,
      this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            // spreadRadius: 5,
            blurRadius: 4,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),

      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isList
                      ? const Icon(
                          Icons.favorite,
                          size: 20,
                        )
                      : const SizedBox(),
                  isList ? const SizedBox(width: 16) : const SizedBox(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Papel Higiênico",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: text)),
                        // const SizedBox(width: 4, height: 4),
                        isList
                            ? const Row(
                                children: [
                                  SizedBox(width: 8, height: 8),
                                  SizedBox(width: 8, height: 8),
                                  SizedBox(width: 8, height: 8),
                                  SizedBox(width: 8, height: 8)
                                ],
                              )
                            : Text("Higiene",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink[200])),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            "RS",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primary),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "39,99",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: text),
                          ),
                        ],
                      ),
                      // const SizedBox(width: 4, height: 4),
                      Text(
                        "QTD. 7",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: primary),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
