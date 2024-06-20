import 'package:flutter/material.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/product.dart';
import 'package:listedin/app/data/model/product_list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/data/repositories/product_list_repository.dart';
import 'package:listedin/app/pages/market_mode/market_mode.dart';

class ListStore {
  final IListRepository repository;
  List<ProductList> listBackup = [];
  List<ProductsBuy> productsBuyBackup = [];
  ShopList list;
  Product? productToAdd;
  double quantityToUpdate = 0;

// loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<double> price = ValueNotifier<double>(0.0);
  final ValueNotifier<double> quantity = ValueNotifier<double>(0.0);
  //Várivel reativa para o state
  final ValueNotifier<ShopList?> state = ValueNotifier<ShopList?>(null);
  final ValueNotifier<List<ProductsBuy>> productsState =
      ValueNotifier<List<ProductsBuy>>([]);

  patchName(value) async {
    try {
      await repository.patchName(state.value!.id, value);
      ShopList list = state.value!;
      list.name = value;
    } catch (e) {
      error.value = e.toString();
    }
  }

  setState() {
    state.value = list;
    listBackup = list.products!;
  }

  quantityToPatch(value) {
    quantityToUpdate = double.parse(value);
  }

  Future confirmProductToList() async {
    ProductListRepository productListRepository =
        ProductListRepository(HttpClient());
    print(productToAdd!.id!);
    print(list.id);
    ProductList result = await productListRepository.create(ProductList(
        productToAdd!.id!,
        list.id,
        list,
        productToAdd!,
        1,
        productToAdd!.price!));
    listBackup.add(result);
    state.value!.products = listBackup;
    List<ProductsBuy> listBuy = productsState.value;
    listBuy.add(ProductsBuy(result, false));
    productsState.value = List.from(listBuy);
    productsState.notifyListeners();
    state.notifyListeners();
  }

  Future patchProductList(ProductList item, index) async {
    ProductListRepository productListRepository =
        ProductListRepository(HttpClient());
    try {
      ProductList result = await productListRepository.patchProductQunatity(
          item.productId, item.listId, quantityToUpdate);
      List<ProductList> list = state.value!.products!;
      list[index] = result;
      state.value!.products = List.from(list);
      List<ProductsBuy> listBuy = productsState.value;
      int ind = listBuy.indexWhere((element) =>
          element.product.productId == result.productId &&
          element.product.listId == result.listId);
      listBuy[ind].product = result;
      productsState.value = List.from(listBuy);
      productsState.notifyListeners();
      state.notifyListeners();
    } catch (e) {
      error.value = e.toString();
    }
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

  void addProductToList(product) {
    productToAdd = product;
  }

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
            element.product.product.name
                .toLowerCase()
                .contains(value.toLowerCase())));
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
