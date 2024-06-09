import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:listedin/app/data/model/list.dart';
import 'package:listedin/app/data/repositories/list_repository.dart';
import 'package:listedin/app/data/repositories/user_repository.dart';

import '../../../data/model/user.dart';

class LoginInfo {
  String? name;
  String? password;

  LoginInfo({this.name, this.password});
}

class LoginStore {
  final IUserRepository repository;

// loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //Várivel reativa para o state
  final ValueNotifier<LoginInfo> state = ValueNotifier<LoginInfo>(LoginInfo());
  final ValueNotifier<User? > userLogged = ValueNotifier<User?>(null);

  //Variável reativa para o erro
  final ValueNotifier<String> error = ValueNotifier('');

  void updateEmail(String value) {
    state.value.name = value;
  }

  void updatePassword(String value) {
    state.value.password = value;
  }

  Future login() async {
    try {
      userLogged.value =
          await repository.login(state.value.name!, state.value.password!);
    } catch (e) {
      error.value = e.toString();
    }
  }

  LoginStore({required this.repository});
}
