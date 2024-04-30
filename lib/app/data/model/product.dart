import 'package:listedin/app/data/model/category.dart';

class Product {
  int id;
  String name;
  double price;
  Category category;
  // List<ProductList> productList
  // User user;

  Product(this.id, this.name, this.price, this.category);

  factory Product.fromJSON(Map<String, dynamic> map) {
    return Product(map["id"], map["name"], map["price"],
        Category.fromJSON(map["category"]));
  }

  Map<String, dynamic> toJSON(){
    Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["category"] = category.toJSON();
    return data;
  }

}
