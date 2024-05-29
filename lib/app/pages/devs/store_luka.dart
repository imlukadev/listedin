

import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';

class ListStore {
  final IListRepository repository;
  List<ShopList> listBackup = [];

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //Várivel reativa para o state
  final ValueNotifier<List<ShopList>> state = ValueNotifier<List<ShopList>>([]);

  //Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier("");

  Future<dynamic> patchIsFavorited(ShopList list) async {
    try {
      final result =
          await repository.patchIsFavorited(list.id, !list.isFavorited);

      int listIndex =
          state.value.indexWhere((element) => list.id == element.id);
      state.value[listIndex] = result;
      state.value = List.from(state.value);
    } catch (e) {
      error.value = e.toString();
    }
  }

  void searchLists(String value) {
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

  Future getLists() async {
    isLoading.value = true;
    try {
      final result = await repository.findAll();
      state.value = result;
      listBackup = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  ListStore({required this.repository});
}
