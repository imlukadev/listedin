import 'dart:ffi';

import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';

class ProductList {
  int productId;
  int listId;
  ShopList list;
  Product product;
  Double quantity;
  Double price;

  ProductList(this.productId, this.listId, this.list, this.product,
      this.quantity, this.price);

  factory ProductList.fromJson(Map<String, dynamic> map) {
    return ProductList(
        map['productId'],
        map['listId'],
        ShopList.fromJSON(map['list']),
        Product.fromJson(map['product']),
        map['quantity'],
        map['price']);
  }
}
