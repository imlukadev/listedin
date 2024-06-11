import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';

class ListStore {
  final IListRepository repository;
  ShopList list;

// loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //Várivel reativa para o state
  final ValueNotifier<ShopList?> state = ValueNotifier<ShopList?>(null);

  setState() {
    print(list.products![0].toJSON());
    state.value = list;
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

  Future<dynamic> deleteList() async {
    try {
      await repository.delete(list.id);
    } catch (e) {
      error.value = e.toString();
    }
  }

  ListStore({required this.repository, required this.list});
}
