import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';

class ProductList {
  int productId;
  int listId;
  ShopList list;
  Product product;
  double quantity;
  double price;

  ProductList(this.productId, this.listId, this.list, this.product,
      this.quantity, this.price);

  factory ProductList.fromJSON(Map<String, dynamic> map) {
    print(map);
    print('object');
    return ProductList(
        map['productId'],
        map['listId'],
        ShopList.fromJSON(map['list']),
        Product.fromJSON(map['product']),
        map['quantity'],
        map['price']);
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['productId'];
    data['listId'];
    data['list'] = list.toJSON();
    data['product'] = product.toJSON();
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
