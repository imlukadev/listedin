import 'package:listedin/app/data/model/category.dart';
import 'package:listedin/app/data/model/product_list.dart';
import 'package:listedin/app/data/model/user.dart';

class Product {
  int? id;
  String name;
  double price;
  Category category;
  User? user;
  List<ProductList>? lists;

  Product(this.name, this.price, this.category,
      {this.id, this.user, this.lists});

  factory Product.fromJSON(Map<String, dynamic> map) {
    return Product(
        map['name'], map['price'], Category.fromJSON(map['category']),
        id: map['id'],
        user: map.keys.contains('user') ? User.fromJSON(map['user']) : null,
        lists: map['lists'] != null
            ? (map['lists'] as List<dynamic>)
                .map((list) => ProductList.fromJSON(list))
                .toList()
            : []);
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data["name"] = name;
    data["price"] = price;
    data["category"] = category.toJSON();
    return data;
  }

  Map<String, dynamic> toCreateJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["price"] = price;
    data["category"] = category.toJSON();
    data["user"] = user!.toSimpleJSON();
    return data;
  }
}
