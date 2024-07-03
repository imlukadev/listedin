import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/model/user.dart';

class UserStore {
  final User user;
  final ValueNotifier<User?> state = ValueNotifier<User?>(null);

  bool verifyIfExistsUser() {
    return state.value != null;
  }

  void syncLists(ShopList list, {bool isAdding = false, bool isRemoving = false}) {
    if (isRemoving) user.lists!.removeWhere((element) => element.id == list.id);
    if (isAdding) user.lists!.add(list);
    user.lists = user.lists!.map((e) {
      if (e.id == list.id) {
        return list;
      }
      return e;
    }).toList();
  }

  UserStore({required this.user}) {
    state.value = user;
  }
}
