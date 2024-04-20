import 'dart:convert';

import 'package:listedin/app/data/model/category.dart';

class ShopList {
  int id;
  String name;
  bool isFavorited;
  DateTime lastAccess;
  int purchasedQuantity;
  List<Category> categories;

  ShopList(this.id, this.name, this.isFavorited, this.lastAccess,
      this.purchasedQuantity, this.categories);

  factory ShopList.fromJSON(Map<String, dynamic> map) {
    List<dynamic> list = json.decode(map['categories']);
    return ShopList(
        map['id'],
        map['name'],
        map['isFavorited'],
        DateTime.parse(map['lastAccess']),
        map['purchasedQuantity'],
        list
            .map((category) =>
                Category.fromJSON(category as Map<String, dynamic>))
            .toList()

        );
  }
}
