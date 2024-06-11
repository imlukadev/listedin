import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/user.dart';
import 'package:listedin/app/data/repositories/user_repository.dart';

class ListStore {
  final IUserRepository repository;
  List<ShopList> listBackup = [];

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //Várivel reativa para o state
  final ValueNotifier<User> state = ValueNotifier<User>(User("", ""));

  //Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier("");

  // Future<dynamic> patchIsFavorited(ShopList list) async {
  //   try {
  //     final result =
  //         await repository.patchIsFavorited(list.id, !list.isFavorited);

  //     int listIndex =
  //         state.value.indexWhere((element) => list.id == element.id);
  //     state.value[listIndex] = result;
  //     state.value = List.from(state.value);
  //   } catch (e) {
  //     error.value = e.toString();
  //   }
  // }

  // void searchLists(String value) {
  //   try {
  //     if (value.isNotEmpty) {
  //       List<ShopList> list = List.from(
  //           state.value.where((element) => element.name.contains(value)));
  //       state.value = List.from(list);
  //     } else {
  //       state.value = listBackup;
  //     }
  //   } catch (e) {
  //     error.value = e.toString();
  //   }
  // }

  // Future getLists() async {
  //   isLoading.value = true;
  //   try {
  //     final result = await repository.findAll();
  //     state.value = result;
  //     listBackup = result;
  //   } catch (e) {
  //     error.value = e.toString();
  //   }

  //   isLoading.value = false;
  // }

  Future getUser() async {
    isLoading.value = true;

    print("bomdia");
    final result = await repository.findById(1);
    print(result);
    state.value = result;
  }

  ListStore({required this.repository});
}
