import 'package:listedin/app/data/model/File.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';

class User {
  int id;
  String name;
  String password;
  String email;
  File image;
  List<ShopList> lists;
  List<Product> createdProducts;
  bool isDark;
  bool isNotificationsActive;

  User(this.id, this.name, this.password, this.email, this.image, this.lists,
      this.createdProducts, this.isDark, this.isNotificationsActive);
  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        map["id"],
        map["name"],
        map["password"],
        map["email"],
        File.fromJson(map["image"]),
        map["lists"].map((list) => ShopList.fromJSON(list)).toList(),
        map["createdProducts"]
            .map((product) => Product.fromJson(product))
            .toList(),
        map["isDark"],
        map["isNotificationsActive"]);
  }
}
