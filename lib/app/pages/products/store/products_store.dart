import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/category.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';
import 'package:listedin/app/data/repositories/product_repository.dart';

import '../../../data/model/user.dart';

class CreateProduct {
  String? name;
  double? price;
  User? user;
  Category? category;

  CreateProduct({this.name, this.user, this.price, this.category});
}

class ProductsStore {
  final IProductRepository repository;
  final User user;
  List<Product> listBackup = [];

// loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //Várivel reativa para o state
  final ValueNotifier<List<Product>> state = ValueNotifier<List<Product>>([]);
  final ValueNotifier<CreateProduct> signProduct =
      ValueNotifier<CreateProduct>(CreateProduct());
  final ValueNotifier<List<Category>> categoryState =
      ValueNotifier<List<Category>>([]);

  //Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier("");

  void updatePrice(String value) {
    signProduct.value.price = double.parse(value);
  }

  Future deleteProduct(Product product) async {
    try {
      await repository.delete(product.id!);
      print("Deletamo");
      print(product.id!);
      List<Product> list = state.value;
      list.removeWhere((element) => element.id == product.id!);
      state.value = List.from(list);
      state.notifyListeners();
    } catch (e) {}
  }

  Future<Product> updateProduct(Product item) async {
    print("object");
    print(user.id);
    Product result = await repository.update(Product(
      signProduct.value.name ?? item.name,
      signProduct.value.price ?? item.price,
      signProduct.value.category ?? item.category,
      id: item.id,
      user: user,
    ));
    print(result.price);
    List<Product> list = state.value;
    int index = list.indexWhere((element) => element.id == item.id);
    list[index] = result;
    state.value = List.from(list);
    return result;
  }

  Future<Product> createProduct() async {
    print(user);
    Product result = await repository.create(Product(signProduct.value.name!,
        signProduct.value.price!, signProduct.value.category!,
        user: user));
    List<Product> list = state.value;
    list.add(result);
    state.value = List.from(list);
    signProduct.value.category = null;
    signProduct.value.price = null;
    signProduct.value.name = null;
    return result;
  }

  void updateName(value) {
    signProduct.value.name = value;
  }

  void uppdateCategory(value) {
    signProduct.value.category = value;
  }

  void searchProducts(String value) {
    try {
      if (value.isNotEmpty) {
        List<ShopList> list = List.from(
            listBackup.where((element) => element.name.contains(value)));
        state.value = List.from(list);
      } else {
        state.value = listBackup;
      }
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future getCategories() async {
    try {
      List<Category> result = await repository.findCategories();
      print(result);
      categoryState.value = List.from(result);
    } catch (e) {
      print(e.toString());
      error.value = e.toString();
    }
  }

  getProducts() {
    isLoading.value = true;
    final result = user.createdProducts!;
    state.value = result;
    listBackup = result;
    isLoading.value = false;
  }

  ProductsStore({required this.repository, required this.user});
}
