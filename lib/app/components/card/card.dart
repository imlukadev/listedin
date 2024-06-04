import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';
import 'package:listedin/app/styles/colors.dart';

class CardBuy extends StatelessWidget {
  final bool isDarkMode;
  final bool isList;
  final ShopList? list;
  final Product? product;
  final Function()? toggleFavorited;

  const CardBuy(
      {super.key,
      this.isDarkMode = false,
      this.isList = false,
      this.list,
      this.toggleFavorited,
      this.product});
  @override
  Widget build(BuildContext context) {
    String calcListPrice() {
      double totalPrice = 0;
      for (var element in list!.products!) {
        totalPrice += element.price;
      }
      totalPrice.toStringAsFixed(2).replaceFirst('.', ',');
      return totalPrice.toStringAsFixed(2).replaceFirst('.', ',');
    }

    String calcListQTD() {
      double totalItens = 0;
      for (var element in list!.products!) {
        totalItens += element.quantity;
      }
      // totalItens.toStringAsFixed(2).replaceFirst('.', ',');
      return totalItens.ceil().toString();
    }

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
                      ? InkWell(
                          onTap: toggleFavorited,
                          child: list!.isFavorited
                              ? Icon(
                                  Icons.favorite,
                                  color: primary,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.favorite_outline_sharp,
                                  size: 20,
                                ),
                        )
                      : const SizedBox(),
                  isList ? const SizedBox(width: 16) : const SizedBox(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(isList ? list!.name : product!.name,
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
                            : Text(product!.category.name,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: product!.category.color)
                                    ),
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
                            isList
                                ? calcListPrice()
                                : product!.price.toString(),
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
                        "QTD. ${calcListQTD()}",
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
