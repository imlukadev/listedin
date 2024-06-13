import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';
import 'package:listedin/app/data/model/product_list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';

class ListStore {
  final IListRepository repository;
  List<ProductList> listBackup = [];
  ShopList list;

// loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //Várivel reativa para o state
  final ValueNotifier<ShopList?> state = ValueNotifier<ShopList?>(null);

  setState() {
    state.value = list;
    listBackup = list.products!;
  }

  //Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier("");

  Future<dynamic> patchPurchasedQuantity() async {
    try {
      final result = await repository.patchPurchasedQuantity(
          list.id, list.purchasedQuantity + 1);
      list = result;
      state.value = result;
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future searchProducts(String value) async {
    try {
      ShopList listK = state.value!;
      if (value.isNotEmpty) {
        List<ProductList> list = List.from(listBackup.where(
            (element) => element.product.name
                .toLowerCase()
                .contains(value.toLowerCase())));
        listK.products = list;
        state.value = listK;
        state.notifyListeners();
        // state.value = List.from(list);
      } else {
        listK.products = listBackup;
        state.value = listK;
        state.notifyListeners();
      }
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<dynamic> deleteList() async {
    try {
      await repository.delete(list.id);
    } catch (e) {
      error.value = e.toString();
    }
  }

  ListStore({required this.repository, required this.list});
}
