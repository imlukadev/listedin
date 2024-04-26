import 'dart:ffi';

import 'package:listedin/app/data/model/category.dart';

class Product {
  int id;
  String name;
  Double price;
  Category category;
  // List<ProductList> productList
  // User user;

  Product(this.id, this.name, this.price, this.category);

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(map["id"], map["name"], map["price"],
        Category.fromJSON(map["category"]));
  }
}
