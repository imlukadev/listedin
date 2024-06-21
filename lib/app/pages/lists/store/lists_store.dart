import 'package:flutter/material.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/data/repositories/user_repository.dart';

import '../../../data/model/user.dart';

class ListsStore {
  final IListRepository repository;
  final User user;
  List<ShopList> listBackup = [];

// loading
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

  Future<dynamic> createList() async {
    try {
      List<ShopList> list = state.value;
      ShopList result = await repository.create(user.id!);
      print(result.toJSON());
      list.add(result);
      listBackup.add(result);
      state.value = List.from(listBackup);
      return result;
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

  getLists() async  {
    isLoading.value = true;
    UserRepository userRepository = UserRepository(HttpClient());
    final response = await userRepository.findById(user.id!);
    final result = response.lists ?? [];
    state.value = result;
    listBackup = result;
    isLoading.value = false;
  }

  ListsStore({required this.repository, required this.user});
}
