import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/category.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';
import 'package:listedin/app/data/repositories/product_repository.dart';

import '../../../data/model/user.dart';

class ProductsStore {
  final IProductRepository repository;
  final User user;
  List<Product> listBackup = [];

// loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //Várivel reativa para o state
  final ValueNotifier<List<Product>> state = ValueNotifier<List<Product>>([]);
  final ValueNotifier<List<Category>> categoryState =
      ValueNotifier<List<Category>>([]);

  //Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier("");

  void searchProducts(String value) {
    try {
      if (value.isNotEmpty) {
        List<ShopList> list = List.from(
            state.value.where((element) => element.name.contains(value)));
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
