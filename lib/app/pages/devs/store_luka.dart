import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';

class ListStore {
  final IListRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //Várivel reativa para o state
  final ValueNotifier<List<ShopList>> state = ValueNotifier<List<ShopList>>([]);

  //Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier("");

  Future getLists() async {
    isLoading.value = true;
    try {
      print("object");
      final result = await repository.findAll();
      print(result);
      state.value = result;
    } catch (e) {
      print("CLARO LUKA");
      print(e.toString());
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  ListStore({required this.repository});
}
