import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';
import 'package:listedin/app/data/model/product_list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/pages/market_mode/market_mode.dart';

class ListStore {
  final IListRepository repository;
  List<ProductList> listBackup = [];
  List<ProductsBuy> productsBuyBackup = [];
  ShopList list;

// loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<double> price = ValueNotifier<double>(0.0);
  final ValueNotifier<double> quantity = ValueNotifier<double>(0.0);
  //Várivel reativa para o state
  final ValueNotifier<ShopList?> state = ValueNotifier<ShopList?>(null);
  final ValueNotifier<List<ProductsBuy>> productsState =
      ValueNotifier<List<ProductsBuy>>([]);

  setState() {
    state.value = list;
    listBackup = list.products!;
  }

  buyProduct(index) {
    List<ProductsBuy> list = productsState.value;
    list[index].isBuy = true;
    productsState.value = List.from(list);
    price.value += productsState.value[index].product.price;
    price.notifyListeners();
    quantity.value += productsState.value[index].product.quantity;
    quantity.notifyListeners();
  }

  unBuyProduct(index) {
    List<ProductsBuy> list = productsState.value;
    list[index].isBuy = false;
    productsState.value = List.from(list);
    price.value -= productsState.value[index].product.price;
    price.notifyListeners();
    quantity.value -= productsState.value[index].product.quantity;
    quantity.notifyListeners();
  }

  setProducts(List<ProductsBuy> products) {
    productsState.value = products;
    productsBuyBackup = products;
  }

  //Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier("");

  Future<dynamic> patchPurchasedQuantity() async {
    try {
      final result = await repository.patchPurchasedQuantity(
          list.id, list.purchasedQuantity + 1);
      list = result;
      state.value = result;
          price.value = 0.0;
    price.notifyListeners();
    quantity.value = 0.0;
    quantity.notifyListeners();
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future searchProductsBuy(String value) async {
    try {
      if (value.isNotEmpty) {
        List<ProductsBuy> list = List.from(productsBuyBackup.where((element) =>
            element.product.product.name.toLowerCase().contains(value.toLowerCase())));
        productsState.value = List.from(list);
        productsState.notifyListeners();
        // state.value = List.from(list);
      } else {
        productsState.value = List.from(productsBuyBackup);
        productsState.notifyListeners();
      }
    } catch (e) {
      error.value = e.toString();
    }
  }


  Future searchProducts(String value) async {
    try {
      ShopList listK = state.value!;
      if (value.isNotEmpty) {
        List<ProductList> list = List.from(listBackup.where((element) =>
            element.product.name.toLowerCase().contains(value.toLowerCase())));
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
