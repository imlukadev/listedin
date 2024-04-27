
import 'package:listedin/app/data/model/file.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';

class User {
  int id;
  String name;
  String? password;
  String email;
  File? image;
  List<ShopList>? lists;
  List<Product>? createdProducts;
  bool? isDark;
  bool? isNotificationsActive;

  User(this.id, this.name, this.email, {this.password, this.image, this.lists,
      this.createdProducts, this.isDark, this.isNotificationsActive});


  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        map["id"],
        map["name"],
        password:  map["password"],
        map["email"],
        image: File.fromJson(map["image"]),
        lists:  map["lists"].map((list) => ShopList.fromJSON(list)).toList(),
        createdProducts:  map["createdProducts"]
            .map((product) => Product.fromJson(product))
            .toList(),
        isDark:  map["isDark"],
        isNotificationsActive:  map["isNotificationsActive"]);
  }

    factory User.getDTO(Map<String, dynamic> map) {
    return User(
        map["id"],
        map["name"],
        map["email"]);   
  }

  @override
  String toString(){
    return "id: $id \n name: $name \n email: $email \n ";
  }

  Map<String, dynamic> toJSON(){
      Map<String, dynamic> data = <String, dynamic>{};
      data["id"] = id;
      data["name"] = name;
      data["password"] = password;
      data["email"] = email;
      data["image"] = image!.toJSON();
      data["lists"] = lists!.map((e) => e.toJSON()).toList() ;
      data["createdProducts"] = createdProducts!.map((e) => e.toJSON()).toList();
      data["isDark"] = isDark;
      data["isNotificationsActive"] = isNotificationsActive;
      return data;
  }

  // factory User.toJSON(User user){
  //   return Map["id"] = user.id
  // }

}
