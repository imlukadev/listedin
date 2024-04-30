
import 'dart:collection';

import 'package:dio/dio.dart';
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
        password: map.keys.contains("password") ? map["password"] : "",
        map["email"],
        image: map.keys.contains("image") ? File.fromJson(map["image"]) : null,
        lists:  map.keys.contains("lists") ? (map["lists"] as List<dynamic>).map((list) => ShopList.fromJSON(list)).toList() : null,
        createdProducts: map.keys.contains("createdProducts") ? (map["createdProducts"] as List<dynamic>)
            .map((product) => Product.fromJson(product))
            .toList() 
            : null,
        isDark:  map.keys.contains("isDark") ? map["isDark"] : false,
        isNotificationsActive: map.keys.contains("isNotificationsActive") ? map["isNotificationsActive"] : null
    );
  }


  // static printar(Object o){
  //   print(o)
  // }

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
