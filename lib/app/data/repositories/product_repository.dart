import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/category.dart';
import 'package:listedin/app/data/model/product.dart';

abstract class IProductRepository {
  Future<Product> findById(int id);
  Future<List<Product>> findAll();
  Future<List<Category>> findCategories();
  Future<Product> create(Product product);
  Future<Product> update(Product product);
}

class ProductRepository extends IProductRepository {
  final HttpClient client;
  ProductRepository(this.client);

  @override
  Future<Product> create(Product product) async {
    Map<String, dynamic> jsonObject = product.toJSON();
    Response response = await client.save("/product", jsonObject);
    Map<String, dynamic> productReturned = json.decode(response.data);
    return Product.fromJSON(productReturned);
  }

  @override
  Future<List<Product>> findAll() async {
    try {
      Response response = await client.get("/product");
      List<Map<String, dynamic>> products = response.data;
      return products.map((product) => Product.fromJSON(product)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Category>> findCategories() async {
    try {
      Response response = await client.get("/product/categories");
      List<dynamic> categories = response.data;

      return categories.map((category) => Category.fromJSON(category)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Product> findById(int id) async {
    try {
      Response response = await client.get("/product/$id");
      Map<String, dynamic> product = json.decode(response.data);
      return Product.fromJSON(product);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Product> update(Product product) async {
    Map<String, dynamic> jsonObject = product.toJSON();
    Response response = await client.save("/product", jsonObject);
    Map<String, dynamic> productReturned = json.decode(response.data);
    return Product.fromJSON(productReturned);
  }
}
